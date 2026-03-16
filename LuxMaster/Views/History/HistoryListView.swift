import CoreData
import SwiftUI

struct HistoryListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var lang: LanguageManager
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LuxMeasurement.timestamp, ascending: false)],
        animation: .default
    )
    private var measurements: FetchedResults<LuxMeasurement>

    @State private var searchText = ""
    @State private var showingExport = false

    private var filteredMeasurements: [LuxMeasurement] {
        guard !searchText.isEmpty else { return Array(measurements) }
        return measurements.filter { m in
            m.note?.localizedCaseInsensitiveContains(searchText) == true ||
            m.locationName?.localizedCaseInsensitiveContains(searchText) == true ||
            m.profileName?.localizedCaseInsensitiveContains(searchText) == true ||
            m.luxValue.formattedLux.contains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if measurements.isEmpty {
                    ContentUnavailableView(
                        lang.s("Keine Messungen"),
                        systemImage: "tray",
                        description: Text(lang.s("Gespeicherte Messungen erscheinen hier."))
                    )
                } else {
                    List {
                        ForEach(filteredMeasurements) { measurement in
                            NavigationLink(value: measurement) {
                                MeasurementRowView(measurement: measurement)
                            }
                        }
                        .onDelete(perform: deleteMeasurements)
                    }
                }
            }
            .navigationTitle(lang.s("Verlauf"))
            .searchable(text: $searchText, prompt: Text(lang.s("Suche in Messungen...")))
            .navigationDestination(for: LuxMeasurement.self) { measurement in
                MeasurementDetailView(measurement: measurement)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                if !measurements.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button { showingExport = true } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingExport) {
                ExportView(measurements: Array(measurements))
            }
        }
    }

    private func deleteMeasurements(at offsets: IndexSet) {
        let toDelete = offsets.map { filteredMeasurements[$0] }
        for measurement in toDelete {
            viewContext.delete(measurement)
        }
        try? viewContext.save()
    }
}
