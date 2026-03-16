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
    private let spotSize: CGFloat = 180

    private var luxValue: Double {
        screenshotMode ? demoLux : cameraManager.smoothedLux
    }

    private var luxRange: LuxRange {
        screenshotMode ? demoRange : LuxRange.from(lux: cameraManager.smoothedLux)
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            if !screenshotMode && !cameraManager.permissionGranted {
                cameraPermissionView
            } else {
                VStack(spacing: 0) {
                    // Top bar
                    if !screenshotMode {
                        HStack {
                            Spacer()
                            Button {
                                cameraManager.toggleExposureLock()
                            } label: {
                                Image(systemName: cameraManager.isExposureLocked ? "lock.fill" : "lock.open")
                                    .font(.body)
                                    .foregroundStyle(cameraManager.isExposureLocked ? .yellow : .secondary)
                                    .padding(10)
                                    .background(.quaternary, in: Circle())
                            }
                            Button {
                                cameraManager.switchCamera()
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                    .padding(10)
                                    .background(.quaternary, in: Circle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                    }

                    Spacer()

                    // Camera spot
                    ZStack {
                        if screenshotMode {
                            LinearGradient(
                                colors: [.black, Color(red: 0.1, green: 0.1, blue: 0.2)],
                                startPoint: .top, endPoint: .bottom
                            )
                        } else {
                            CameraPreviewView(session: cameraManager.captureSession)
                        }

                        // Crosshair
                        crosshair
                    }
                    .frame(width: spotSize, height: spotSize)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 12, y: 4)

                    Spacer()
                        .frame(height: 24)

                    // Lux display
                    LuxDisplayView(luxValue: luxValue, luxRange: luxRange)

                    Spacer()
                        .frame(height: 16)

                    // Controls
                    MeasurementControlsView(
                        luxValue: luxValue,
                        luxRange: luxRange,
                        onSave: {
                            savedLux = cameraManager.smoothedLux
                            savedISO = Double(cameraManager.currentISO)
                            savedExposure = cameraManager.currentExposureDuration
                            showingSaveSheet = true
                        }
                    )
                    .padding(.horizontal)

                    Spacer()
                        .frame(height: 16)

                    // Technical details
                    if screenshotMode {
                        HStack(spacing: 16) {
                            Label("ISO 64", systemImage: "camera.aperture")
                            Label("1/125s", systemImage: "timer")
                            Label("38%", systemImage: "sun.min.fill")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(.quaternary, in: Capsule())
                    } else {
                        technicalDetails
                    }

                    Spacer()
                }
                .padding(.bottom, 8)
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

    // MARK: - Crosshair

    private var crosshair: some View {
        let lineLength: CGFloat = 16
        let lineWidth: CGFloat = 1
        let color = Color.white.opacity(0.6)

        return ZStack {
            // Horizontal
            Rectangle()
                .fill(color)
                .frame(width: lineLength, height: lineWidth)
                .offset(x: -lineLength / 2 - 2)
            Rectangle()
                .fill(color)
                .frame(width: lineLength, height: lineWidth)
                .offset(x: lineLength / 2 + 2)
            // Vertical
            Rectangle()
                .fill(color)
                .frame(width: lineWidth, height: lineLength)
                .offset(y: -lineLength / 2 - 2)
            Rectangle()
                .fill(color)
                .frame(width: lineWidth, height: lineLength)
                .offset(y: lineLength / 2 + 2)
        }
    }

    // MARK: - Permission

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

    // MARK: - Technical Details

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
        .foregroundStyle(.secondary)
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(.quaternary, in: Capsule())
    }

    private func formatExposure(_ duration: Double) -> String {
        guard duration > 0 else { return "-" }
        if duration >= 1 { return String(format: "%.1fs", duration) }
        return "1/\(Int(1.0 / duration))s"
    }
}
