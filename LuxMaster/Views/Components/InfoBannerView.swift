import SwiftUI

struct InfoBannerView: View {
    let isCalibrated: Bool
    let stability: Double
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        HStack(spacing: 12) {
            Label {
                Text(isCalibrated ? lang.s("Kalibriert") : lang.s("Nicht kalibriert"))
                    .font(.caption)
            } icon: {
                Image(systemName: isCalibrated ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                    .foregroundStyle(isCalibrated ? .green : .orange)
            }

            Divider().frame(height: 16)

            Label {
                Text(stabilityText).font(.caption)
            } icon: {
                Image(systemName: stabilityIcon)
                    .foregroundStyle(stabilityColor)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.quaternary, in: Capsule())
    }

    private var stabilityText: String {
        switch stability {
        case 0.9...: return lang.s("Stabil")
        case 0.7..<0.9: return lang.s("Schwankend")
        default: return lang.s("Instabil")
        }
    }

    private var stabilityIcon: String {
        switch stability {
        case 0.9...: return "waveform.path"
        case 0.7..<0.9: return "waveform"
        default: return "waveform.badge.exclamationmark"
        }
    }

    private var stabilityColor: Color {
        switch stability {
        case 0.9...: return .green
        case 0.7..<0.9: return .yellow
        default: return .red
        }
    }
}
