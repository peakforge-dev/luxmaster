import CoreData
import CoreLocation
import SwiftUI

struct SaveMeasurementSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager

    let luxValue: Double
    let iso: Double
    let exposureDuration: Double

    @StateObject private var locationManager = LocationManager()
    @State private var note: String = ""
    @State private var includeLocation: Bool = false
    @State private var selectedProfile: MeasurementProfile = .general
    @State private var showError = false

    var body: some View {
        NavigationStack {
            Form {
                Section(lang.s("Messwert")) {
                    LabeledContent("Lux", value: luxValue.formattedLuxWithUnit)
                    LabeledContent(lang.s("Bereich"), value: LuxRange.from(lux: luxValue).localizedName)
                    LabeledContent("ISO", value: "\(Int(iso))")
                }

                Section(lang.s("Notiz")) {
                    TextField(lang.s("Optionale Notiz..."), text: $note, axis: .vertical)
                        .lineLimit(3)
                }

                Section(lang.s("Profil")) {
                    Picker(lang.s("Messprofil"), selection: $selectedProfile) {
                        ForEach(MeasurementProfile.allCases) { profile in
                            Label(profile.localizedName, systemImage: profile.icon)
                                .tag(profile)
                        }
                    }
                }

                Section(lang.s("Standort")) {
                    Toggle(lang.s("Standort speichern"), isOn: $includeLocation)
                    if includeLocation {
                        if let name = locationManager.locationName {
                            Label(name, systemImage: "location.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else if locationManager.authorizationStatus == .notDetermined {
                            Button(lang.s("Standortzugriff erlauben")) {
                                locationManager.requestPermission()
                            }
                        } else {
                            Label(lang.s("Standort wird ermittelt..."), systemImage: "location.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle(lang.s("Messung speichern"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.s("Abbrechen")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.s("Speichern")) { save() }
                        .bold()
                }
            }
            .alert(lang.s("Fehler beim Speichern"), isPresented: $showError) {
                Button(lang.s("OK")) {}
            }
            .onChange(of: includeLocation) { _, newValue in
                if newValue { locationManager.requestLocation() }
            }
        }
    }

    private func save() {
        do {
            try PersistenceController.shared.saveMeasurement(
                luxValue: luxValue,
                note: note.isEmpty ? nil : note,
                latitude: includeLocation ? locationManager.currentLocation?.coordinate.latitude : nil,
                longitude: includeLocation ? locationManager.currentLocation?.coordinate.longitude : nil,
                locationName: includeLocation ? locationManager.locationName : nil,
                profileName: selectedProfile.rawValue,
                iso: iso,
                exposureDuration: exposureDuration
            )
            dismiss()
        } catch {
            showError = true
        }
    }
}
