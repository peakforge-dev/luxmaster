import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var calibrationManager: CalibrationManager
    @EnvironmentObject var lang: LanguageManager
    @AppStorage("screenshotMode") private var screenshotMode = false
    @State private var showingCalibration = false
    @State private var showingDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                Section(lang.s("Sprache")) {
                    Picker(lang.s("Sprache"), selection: $lang.currentLanguage) {
                        ForEach(LanguageManager.supportedLanguages) { language in
                            Text("\(language.flag) \(language.name)")
                                .tag(language.code)
                        }
                    }
                }

                Section(lang.s("Kalibrierung")) {
                    if let profile = calibrationManager.activeProfile {
                        VStack(alignment: .leading, spacing: 4) {
                            Label(lang.s("Kalibriert"), systemImage: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                            Text("\(lang.s("Kalibrierpunkte")): \(profile.calibrationPoints.count)")
                                .font(.caption).foregroundStyle(.secondary)
                            Text("\(lang.s("Faktor")): \(String(format: "%.3f", profile.calibrationFactor))")
                                .font(.caption).foregroundStyle(.secondary)
                            Text("\(lang.s("Datum")): \(profile.calibrationDate.formattedShort)")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    } else {
                        Label(lang.s("Nicht kalibriert"), systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        Text(lang.s("Ohne Kalibrierung beträgt die Genauigkeit ca. +/-30%."))
                            .font(.caption).foregroundStyle(.secondary)
                    }

                    Button(lang.s("Neue Kalibrierung starten")) { showingCalibration = true }

                    if !calibrationManager.profiles.isEmpty {
                        NavigationLink(lang.s("Kalibrierungsprofile verwalten")) {
                            calibrationProfilesList
                        }
                    }
                }

                Section(lang.s("Messhinweise")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label(lang.s("Kamera-basierte Messung"), systemImage: "info.circle")
                            .font(.subheadline.bold())
                        Text(lang.s("LuxMaster nutzt den Kamerasensor zur Lux-Berechnung. Die Genauigkeit hängt vom iPhone-Modell und der Kalibrierung ab."))
                            .font(.caption).foregroundStyle(.secondary)
                    }
                }

                Section(lang.s("Datenschutz")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label(lang.s("Keine Bilder werden gespeichert"), systemImage: "eye.slash.fill")
                            .font(.subheadline.bold())
                        Text(lang.s("Kamera-Frames werden ausschließlich im Arbeitsspeicher für die Helligkeitsberechnung analysiert und sofort verworfen."))
                            .font(.caption).foregroundStyle(.secondary)
                    }
                }

                Section(lang.s("Daten")) {
                    Button(lang.s("Alle Messungen löschen"), role: .destructive) {
                        showingDeleteConfirmation = true
                    }
                }

                Section("Screenshot") {
                    Toggle(lang.s("Screenshot-Modus"), isOn: $screenshotMode)
                }

                Section(lang.s("Info")) {
                    LabeledContent(lang.s("App"), value: AppConstants.appName)
                    LabeledContent(lang.s("Version"), value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    LabeledContent(lang.s("Gerät"), value: DeviceInfo.modelIdentifier)
                }
            }
            .navigationTitle(lang.s("Einstellungen"))
            .sheet(isPresented: $showingCalibration) {
                CalibrationView()
            }
            .confirmationDialog(lang.s("Alle Messungen löschen?"), isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
                Button(lang.s("Alle löschen"), role: .destructive) {
                    try? PersistenceController.shared.deleteAllMeasurements()
                }
                Button(lang.s("Abbrechen"), role: .cancel) {}
            } message: {
                Text(lang.s("Diese Aktion kann nicht rückgängig gemacht werden."))
            }
        }
    }

    private var calibrationProfilesList: some View {
        List {
            ForEach(calibrationManager.profiles) { profile in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(profile.deviceModel).font(.headline)
                        if profile.isActive {
                            Text(lang.s("Aktiv")).font(.caption2)
                                .padding(.horizontal, 6).padding(.vertical, 2)
                                .background(.green.opacity(0.2), in: Capsule())
                        }
                    }
                    Text("\(lang.s("Faktor")): \(String(format: "%.3f", profile.calibrationFactor))").font(.caption)
                    Text("\(lang.s("Punkte")): \(profile.calibrationPoints.count)").font(.caption)
                    Text(profile.calibrationDate.formattedShort).font(.caption2).foregroundStyle(.secondary)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        calibrationManager.deleteProfile(profile)
                    } label: { Label(lang.s("Löschen"), systemImage: "trash") }
                    if !profile.isActive {
                        Button {
                            calibrationManager.activateProfile(profile)
                        } label: { Label(lang.s("Aktivieren"), systemImage: "checkmark") }
                            .tint(.green)
                    }
                }
            }
        }
        .navigationTitle(lang.s("Kalibrierungsprofile"))
    }
}
