import SwiftUI

struct MeasurementRowView: View {
    let measurement: LuxMeasurement

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(measurement.luxRange.color)
                .frame(width: 10, height: 10)

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(measurement.luxValue.formattedLuxWithUnit)
                        .font(.headline)

                    if let profile = measurement.profile {
                        Text(profile.localizedName)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.quaternary, in: Capsule())
                    }
                }

                HStack(spacing: 8) {
                    Text(measurement.timestamp?.formattedRelative ?? "-")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if let note = measurement.note, !note.isEmpty {
                        Text(note)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }

            Spacer()

            Image(systemName: measurement.luxRange.icon)
                .foregroundStyle(measurement.luxRange.color)
                .font(.title3)
        }
        .padding(.vertical, 2)
    }
}
