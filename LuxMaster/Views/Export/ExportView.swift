import SwiftUI

struct ExportView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var lang: LanguageManager
    let measurements: [LuxMeasurement]

    @State private var selectedFormat: ExportFormat = .csv
    @State private var exportURL: URL?
    @State private var showingShareSheet = false
    @State private var showingError = false

    enum ExportFormat: String, CaseIterable, Identifiable {
        case csv = "CSV"
        case pdf = "PDF"
        var id: String { rawValue }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(lang.s("Format")) {
                    Picker(lang.s("Exportformat"), selection: $selectedFormat) {
                        ForEach(ExportFormat.allCases) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(lang.s("Vorschau")) {
                    LabeledContent(lang.s("Messungen"), value: "\(measurements.count)")
                    if let first = measurements.last?.timestamp {
                        LabeledContent(lang.s("Von"), value: first.formattedShort)
                    }
                    if let last = measurements.first?.timestamp {
                        LabeledContent(lang.s("Bis"), value: last.formattedShort)
                    }
                    let values = measurements.map(\.luxValue)
                    if !values.isEmpty {
                        let avg = values.reduce(0, +) / Double(values.count)
                        LabeledContent(lang.s("Durchschnitt"), value: avg.formattedLuxWithUnit)
                    }
                }

                Section {
                    Button { exportData() } label: {
                        Label(lang.s("Exportieren"), systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(measurements.isEmpty)
                }
            }
            .navigationTitle(lang.s("Export"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.s("Abbrechen")) { dismiss() }
                }
            }
            .sheet(isPresented: $showingShareSheet) {
                if let url = exportURL {
                    ShareSheet(items: [url])
                }
            }
            .alert(lang.s("Export fehlgeschlagen"), isPresented: $showingError) {
                Button(lang.s("OK")) {}
            }
        }
    }

    private func exportData() {
        let url: URL? = switch selectedFormat {
        case .csv: ExportService.generateCSV(from: measurements)
        case .pdf: ExportService.generatePDF(from: measurements)
        }
        if let url {
            exportURL = url
            showingShareSheet = true
        } else {
            showingError = true
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
