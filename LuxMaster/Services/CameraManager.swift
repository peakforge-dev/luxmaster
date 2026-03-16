import AVFoundation
import Combine
import CoreMedia
import SwiftUI

enum CameraError: LocalizedError {
    case permissionDenied
    case deviceNotAvailable
    case sessionConfigurationFailed
    case inputError(Error)

    var errorDescription: String? {
        let code = UserDefaults.standard.string(forKey: "appLanguage") ?? "de"
        func t(_ key: String) -> String {
            if code == "de" { return key }
            return Translations.data[key]?[code] ?? key
        }
        switch self {
        case .permissionDenied:
            return t("Kamerazugriff wurde verweigert. Bitte in den Einstellungen erlauben.")
        case .deviceNotAvailable:
            return t("Keine geeignete Kamera gefunden.")
        case .sessionConfigurationFailed:
            return t("Kamera konnte nicht konfiguriert werden.")
        case .inputError(let error):
            return String(format: t("Kamerafehler: %@"), error.localizedDescription)
        }
    }
}

@MainActor
class CameraManager: NSObject, ObservableObject {
    @Published var currentLux: Double = 0
    @Published var smoothedLux: Double = 0
    @Published var currentISO: Float = 0
    @Published var currentExposureDuration: Double = 0
    @Published var currentBrightness: Double = 0
    @Published var isRunning: Bool = false
    @Published var permissionGranted: Bool = false
    @Published var error: CameraError?
    @Published var stability: Double = 0
    @Published var cameraPosition: AVCaptureDevice.Position = .back
    @Published var isExposureLocked: Bool = false

    let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sessionQueue = DispatchQueue(label: "com.luxmaster.camera")
    nonisolated(unsafe) var captureDevice: AVCaptureDevice?
    private let smoother = LuxSmoother()
    private nonisolated(unsafe) var frameCount: Int = 0

    nonisolated(unsafe) var calibrationProfile: CalibrationProfile?
    var deviceAperture: Float { captureDevice?.lensAperture ?? AppConstants.defaultAperture }

    override init() {
        super.init()
        checkPermission()
    }

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            permissionGranted = true
            setupSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                Task { @MainActor in
                    self?.permissionGranted = granted
                    if granted {
                        self?.setupSession()
                    } else {
                        self?.error = .permissionDenied
                    }
                }
            }
        default:
            permissionGranted = false
            error = .permissionDenied
        }
    }

    private func setupSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            self.captureSession.beginConfiguration()
            self.captureSession.sessionPreset = .medium

            guard let device = AVCaptureDevice.default(
                .builtInWideAngleCamera, for: .video, position: self.cameraPosition
            ) else {
                Task { @MainActor in self.error = .deviceNotAvailable }
                return
            }
            self.captureDevice = device

            do {
                let input = try AVCaptureDeviceInput(device: device)
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
            } catch {
                Task { @MainActor in self.error = .inputError(error) }
                self.captureSession.commitConfiguration()
                return
            }

            self.videoOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
            self.videoOutput.videoSettings = [
                kCVPixelBufferPixelFormatTypeKey as String:
                    kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
            ]
            self.videoOutput.alwaysDiscardsLateVideoFrames = true

            if self.captureSession.canAddOutput(self.videoOutput) {
                self.captureSession.addOutput(self.videoOutput)
            }

            self.captureSession.commitConfiguration()
            self.captureSession.startRunning()
            Task { @MainActor in self.isRunning = true }
        }
    }

    func startSession() {
        guard !captureSession.isRunning else { return }
        sessionQueue.async { [weak self] in
            self?.captureSession.startRunning()
            Task { @MainActor in self?.isRunning = true }
        }
    }

    func stopSession() {
        guard captureSession.isRunning else { return }
        if isExposureLocked { unlockExposure() }
        sessionQueue.async { [weak self] in
            self?.captureSession.stopRunning()
            Task { @MainActor in self?.isRunning = false }
        }
    }

    func switchCamera() {
        let newPosition: AVCaptureDevice.Position = cameraPosition == .back ? .front : .back
        cameraPosition = newPosition
        isExposureLocked = false
        smoother.reset()

        sessionQueue.async { [weak self] in
            guard let self else { return }
            self.captureSession.beginConfiguration()

            // Remove existing input
            for input in self.captureSession.inputs {
                self.captureSession.removeInput(input)
            }

            guard let device = AVCaptureDevice.default(
                .builtInWideAngleCamera, for: .video, position: newPosition
            ) else {
                self.captureSession.commitConfiguration()
                Task { @MainActor in self.error = .deviceNotAvailable }
                return
            }
            self.captureDevice = device

            do {
                let input = try AVCaptureDeviceInput(device: device)
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
            } catch {
                Task { @MainActor in self.error = .inputError(error) }
            }

            self.captureSession.commitConfiguration()
        }
    }

    func resetSmoothing() {
        smoother.reset()
    }

    func lockExposure() {
        guard let device = captureDevice else { return }
        sessionQueue.async {
            do {
                try device.lockForConfiguration()
                device.exposureMode = .locked
                device.unlockForConfiguration()
                Task { @MainActor in self.isExposureLocked = true }
            } catch {}
        }
    }

    func unlockExposure() {
        guard let device = captureDevice else { return }
        sessionQueue.async {
            do {
                try device.lockForConfiguration()
                device.exposureMode = .continuousAutoExposure
                device.unlockForConfiguration()
                Task { @MainActor in self.isExposureLocked = false }
            } catch {}
        }
    }

    func toggleExposureLock() {
        if isExposureLocked { unlockExposure() } else { lockExposure() }
    }

    nonisolated private func calculateAverageBrightness(from pixelBuffer: CVPixelBuffer) -> Double {
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }

        guard let baseAddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0) else { return 0 }

        let width = CVPixelBufferGetWidthOfPlane(pixelBuffer, 0)
        let height = CVPixelBufferGetHeightOfPlane(pixelBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 0)
        let buffer = baseAddress.assumingMemoryBound(to: UInt8.self)

        let sampleStep = 6

        // Spot zone: center ~30% of frame (35% margin each side)
        let spotLeft = width * 35 / 100
        let spotRight = width - spotLeft
        let spotTop = height * 35 / 100
        let spotBottom = height - spotTop

        var sum: Double = 0
        var count: Int = 0

        for y in stride(from: spotTop, to: spotBottom, by: sampleStep) {
            for x in stride(from: spotLeft, to: spotRight, by: sampleStep) {
                sum += Double(buffer[y * bytesPerRow + x])
                count += 1
            }
        }

        guard count > 0 else { return 0 }
        return sum / Double(count) / 255.0
    }
}

extension CameraManager: @preconcurrency AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        frameCount += 1
        guard frameCount % AppConstants.frameProcessingInterval == 0 else { return }

        guard let device = captureDevice else { return }
        let iso = device.iso
        let exposureDuration = CMTimeGetSeconds(device.exposureDuration)
        let aperture = device.lensAperture

        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let brightness = calculateAverageBrightness(from: pixelBuffer)

        let calibration = self.calibrationProfile
        let lux = LuxCalculationEngine.calculateLux(
            averageBrightness: brightness,
            iso: iso,
            exposureDuration: exposureDuration,
            aperture: aperture,
            calibrationProfile: calibration
        )

        let smoothed = smoother.addValue(lux)
        let currentStability = smoother.stability

        Task { @MainActor [weak self] in
            self?.currentISO = iso
            self?.currentExposureDuration = exposureDuration
            self?.currentBrightness = brightness
            self?.currentLux = lux
            self?.smoothedLux = smoothed
            self?.stability = currentStability
        }
    }
}
