import SwiftUI

struct MeasurementControlsView: View {
    let luxValue: Double
    let luxRange: LuxRange
    let onSave: () -> Void
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: luxRange.icon)
                    .foregroundStyle(luxRange.color)
                Text(LuxDescriptor.describe(luxValue))
                    .font(.subheadline)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.quaternary, in: Capsule())

            Button(action: onSave) {
                Label(lang.s("Messung speichern"), systemImage: "square.and.arrow.down")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(luxRange.color)
        }
    }
}
