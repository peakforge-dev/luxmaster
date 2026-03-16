import SwiftUI

extension Color {
    static func forLux(_ value: Double) -> Color {
        LuxRange.from(lux: value).color
    }

    static let luxGaugeGradient = Gradient(colors: [
        .indigo, .purple, .blue, .cyan, .green, .mint, .yellow, .orange
    ])
}
