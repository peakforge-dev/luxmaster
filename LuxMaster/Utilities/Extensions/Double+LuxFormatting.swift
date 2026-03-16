import Foundation

extension Double {
    var formattedLux: String {
        if self < 1 {
            return String(format: "%.2f", self)
        } else if self < 100 {
            return String(format: "%.1f", self)
        } else {
            return String(format: "%.0f", self)
        }
    }

    var formattedLuxWithUnit: String {
        "\(formattedLux) lx"
    }
}

extension Float {
    var formattedISO: String {
        "ISO \(Int(self))"
    }
}
