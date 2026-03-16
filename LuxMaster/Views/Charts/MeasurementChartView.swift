import Charts
import SwiftUI

struct MeasurementChartView: View {
    let measurements: [LuxMeasurement]
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(lang.s("Messverlauf"))
                .font(.headline)

            if measurements.isEmpty {
                ContentUnavailableView(
                    lang.s("Keine Daten"),
                    systemImage: "chart.line.downtrend.xyaxis",
                    description: Text(lang.s("Speichere Messungen, um den Verlauf zu sehen."))
                )
            } else {
                Chart(measurements) { measurement in
                    LineMark(
                        x: .value(lang.s("Zeit"), measurement.timestamp ?? Date()),
                        y: .value("Lux", measurement.luxValue)
                    )
                    .foregroundStyle(Color.forLux(measurement.luxValue))
                    .interpolationMethod(.catmullRom)

                    PointMark(
                        x: .value(lang.s("Zeit"), measurement.timestamp ?? Date()),
                        y: .value("Lux", measurement.luxValue)
                    )
                    .foregroundStyle(Color.forLux(measurement.luxValue))
                    .symbolSize(30)
                }
                .chartYAxisLabel("Lux")
                .chartXAxisLabel(lang.s("Zeit"))
                .chartYScale(domain: .automatic(includesZero: true))
                .frame(height: 200)
            }

            if !measurements.isEmpty {
                let values = measurements.map(\.luxValue)
                let avg = values.reduce(0, +) / Double(values.count)

                HStack(spacing: 16) {
                    StatLabel(title: lang.s("Min"), value: (values.min() ?? 0).formattedLuxWithUnit)
                    StatLabel(title: lang.s("Max"), value: (values.max() ?? 0).formattedLuxWithUnit)
                    StatLabel(title: lang.s("Schnitt"), value: avg.formattedLuxWithUnit)
                    StatLabel(title: lang.s("Anzahl"), value: "\(measurements.count)")
                }
                .font(.caption)
            }
        }
        .padding()
    }
}

private struct StatLabel: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 2) {
            Text(title).foregroundStyle(.secondary)
            Text(value).bold()
        }
    }
}
