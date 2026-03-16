import SwiftUI

struct LuxDisplayView: View {
    let luxValue: Double
    let luxRange: LuxRange

    var body: some View {
        VStack(spacing: 4) {
            Text(luxValue.formattedLux)
                .font(.system(size: AppConstants.luxDisplayFontSize, weight: .bold, design: .rounded))
                .foregroundStyle(luxRange.color)
                .contentTransition(.numericText(value: luxValue))
                .animation(.easeInOut(duration: AppConstants.luxAnimationDuration), value: luxValue)

            Text("Lux")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 20) {
            LuxDisplayView(luxValue: 342.5, luxRange: .indoor)
            LuxDisplayView(luxValue: 15200, luxRange: .daylight)
            LuxDisplayView(luxValue: 0.3, luxRange: .darkness)
        }
    }
}
