import CoreData
import SwiftUI

struct MeasurementDetailView: View {
    @ObservedObject var measurement: LuxMeasurement
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var lang: LanguageManager
    @State private var editedNote: String = ""

    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    Text(measurement.luxValue.formattedLux)
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundStyle(measurement.luxRange.color)
                    Text("Lux")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Text(measurement.luxRange.localizedName)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(measurement.luxRange.color.opacity(0.15), in: Capsule())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }

            Section(lang.s("Lichtverhältnisse")) {
                Label(LuxDescriptor.describe(measurement.luxValue), systemImage: measurement.luxRange.icon)
            }

            Section(lang.s("Technische Daten")) {
                if measurement.iso > 0 {
                    LabeledContent("ISO", value: "\(Int(measurement.iso))")
                }
                if measurement.exposureDuration > 0 {
                    LabeledContent(lang.s("Belichtung"), value: measurement.formattedExposure)
                }
                if let device = measurement.deviceModel {
                    LabeledContent(lang.s("Gerät"), value: device)
                }
            }

            Section(lang.s("Details")) {
                if let timestamp = measurement.timestamp {
                    LabeledContent(lang.s("Zeitpunkt"), value: timestamp.formattedLong)
                }
                if let profile = measurement.profile {
                    LabeledContent(lang.s("Profil")) {
                        Label(profile.localizedName, systemImage: profile.icon)
                    }
                }
                if measurement.hasLocation {
                    if let name = measurement.locationName {
                        LabeledContent(lang.s("Standort"), value: name)
                    }
                    LabeledContent(lang.s("Koordinaten")) {
                        Text(String(format: "%.4f, %.4f", measurement.latitude, measurement.longitude))
                            .font(.caption)
                    }
                }
            }

            Section(lang.s("Notiz")) {
                TextField(lang.s("Notiz hinzufügen..."), text: $editedNote, axis: .vertical)
                    .lineLimit(5)
            }
        }
        .navigationTitle(lang.s("Messung"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { editedNote = measurement.note ?? "" }
        .onDisappear {
            if editedNote != (measurement.note ?? "") {
                measurement.note = editedNote.isEmpty ? nil : editedNote
                try? viewContext.save()
            }
        }
    }
}
