import SwiftUI

struct LuxGaugeView: View {
    let luxValue: Double
    let maxLux: Double

    init(luxValue: Double, maxLux: Double = 100000) {
        self.luxValue = luxValue
        self.maxLux = maxLux
    }

    private var normalizedValue: Double {
        guard maxLux > 0 else { return 0 }
        let logValue = log10(Swift.max(luxValue, 1))
        let logMax = log10(maxLux)
        return Swift.min(logValue / logMax, 1.0)
    }

    var body: some View {
        Gauge(value: normalizedValue) {
            EmptyView()
        } currentValueLabel: {
            Text(luxValue.formattedLux)
                .font(.caption.bold())
        } minimumValueLabel: {
            Text("0").font(.caption2)
        } maximumValueLabel: {
            Text("\(Int(maxLux / 1000))k").font(.caption2)
        }
        .gaugeStyle(.accessoryCircular)
        .tint(Color.forLux(luxValue))
    }
}
