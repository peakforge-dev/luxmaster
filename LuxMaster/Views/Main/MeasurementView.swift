import SwiftUI

struct MeasurementView: View {
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var calibrationManager: CalibrationManager
    @EnvironmentObject var lang: LanguageManager
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("screenshotMode") private var screenshotMode = false
    @State private var showingSaveSheet = false
    @State private var savedLux: Double = 0
    @State private var savedISO: Double = 0
    @State private var savedExposure: Double = 0

    private let demoLux: Double = 487.0
    private let demoRange: LuxRange = .indoor

    var body: some View {
        ZStack {
            if screenshotMode {
                LinearGradient(
                    colors: [.black, Color(red: 0.1, green: 0.1, blue: 0.2)],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
            } else if cameraManager.permissionGranted {
                CameraPreviewView(session: cameraManager.captureSession)
                    .ignoresSafeArea()

                Color.black.opacity(0.3)
                    .ignoresSafeArea()
            } else {
                cameraPermissionView
            }

            if screenshotMode || cameraManager.permissionGranted {
                VStack(spacing: 16) {
                    if !screenshotMode {
                        HStack {
                            Spacer()
                            Button {
                                cameraManager.toggleExposureLock()
                            } label: {
                                Image(systemName: cameraManager.isExposureLocked ? "lock.fill" : "lock.open")
                                    .font(.title2)
                                    .foregroundStyle(cameraManager.isExposureLocked ? .yellow : .white)
                                    .padding(12)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                            Button {
                                cameraManager.switchCamera()
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .padding(12)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                        }
                    }

                    Spacer()

                    LuxDisplayView(
                        luxValue: screenshotMode ? demoLux : cameraManager.smoothedLux,
                        luxRange: screenshotMode ? demoRange : LuxRange.from(lux: cameraManager.smoothedLux)
                    )

                    InfoBannerView(
                        isCalibrated: screenshotMode ? true : calibrationManager.isCalibrated,
                        stability: screenshotMode ? 0.95 : cameraManager.stability
                    )

                    MeasurementControlsView(
                        luxValue: screenshotMode ? demoLux : cameraManager.smoothedLux,
                        luxRange: screenshotMode ? demoRange : LuxRange.from(lux: cameraManager.smoothedLux),
                        onSave: {
                            savedLux = cameraManager.smoothedLux
                            savedISO = Double(cameraManager.currentISO)
                            savedExposure = cameraManager.currentExposureDuration
                            showingSaveSheet = true
                        }
                    )

                    if screenshotMode {
                        HStack(spacing: 16) {
                            Label("ISO 64", systemImage: "camera.aperture")
                            Label("1/125s", systemImage: "timer")
                            Label("38%", systemImage: "sun.min.fill")
                        }
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial.opacity(0.5), in: Capsule())
                        .padding(.bottom, 8)
                    } else {
                        technicalDetails
                            .padding(.bottom, 8)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingSaveSheet) {
            SaveMeasurementSheet(
                luxValue: savedLux,
                iso: savedISO,
                exposureDuration: savedExposure
            )
        }
        .onChange(of: scenePhase) { _, newPhase in
            if !screenshotMode {
                switch newPhase {
                case .active: cameraManager.startSession()
                case .inactive, .background: cameraManager.stopSession()
                @unknown default: break
                }
            }
        }
        .onChange(of: calibrationManager.activeProfile) { _, profile in
            cameraManager.calibrationProfile = profile
        }
    }

    private var cameraPermissionView: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera.fill")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text(lang.s("Kamerazugriff erforderlich"))
                .font(.title2.bold())

            Text(lang.s("LuxMaster benötigt Zugriff auf die Kamera, um die Lichtstärke zu messen. Es werden keine Bilder gespeichert."))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)

            if let error = cameraManager.error {
                Text(error.localizedDescription)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.horizontal)
            }

            Button(lang.s("Einstellungen öffnen")) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var technicalDetails: some View {
        HStack(spacing: 16) {
            if cameraManager.isExposureLocked {
                Label(lang.s("AE gesperrt"), systemImage: "lock.fill")
                    .foregroundStyle(.yellow.opacity(0.9))
            }
            Label(cameraManager.currentISO.formattedISO, systemImage: "camera.aperture")
            Label(formatExposure(cameraManager.currentExposureDuration), systemImage: "timer")
            Label(String(format: "%.0f%%", cameraManager.currentBrightness * 100), systemImage: "sun.min.fill")
        }
        .font(.caption)
        .foregroundStyle(.white.opacity(0.7))
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial.opacity(0.5), in: Capsule())
    }

    private func formatExposure(_ duration: Double) -> String {
        guard duration > 0 else { return "-" }
        if duration >= 1 { return String(format: "%.1fs", duration) }
        return "1/\(Int(1.0 / duration))s"
    }
}
