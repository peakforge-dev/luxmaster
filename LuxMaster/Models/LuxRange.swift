import SwiftUI

enum LuxRange: String, CaseIterable {
    case darkness = "Dunkelheit"
    case veryDark = "Sehr dunkel"
    case dim = "Dämmerung"
    case indoor = "Innenraum"
    case brightIndoor = "Heller Innenraum"
    case overcast = "Bewölkt"
    case daylight = "Tageslicht"
    case directSun = "Direktes Sonnenlicht"

    static func from(lux: Double) -> LuxRange {
        switch lux {
        case ..<1: return .darkness
        case 1..<50: return .veryDark
        case 50..<200: return .dim
        case 200..<500: return .indoor
        case 500..<1000: return .brightIndoor
        case 1000..<10000: return .overcast
        case 10000..<25000: return .daylight
        default: return .directSun
        }
    }

    var description: String { rawValue }

    var localizedName: String {
        LanguageManager.shared.s(rawValue)
    }

    var detailedDescription: String {
        switch self {
        case .darkness: return "Nahezu vollständige Dunkelheit"
        case .veryDark: return "Mondlicht, schwache Beleuchtung"
        case .dim: return "Kerzenlicht, gedimmte Räume"
        case .indoor: return "Normaler Wohnraum, Büro"
        case .brightIndoor: return "Gut beleuchteter Arbeitsplatz"
        case .overcast: return "Bewölkter Himmel, Schatten"
        case .daylight: return "Helles Tageslicht"
        case .directSun: return "Direktes Sonnenlicht"
        }
    }

    var localizedDetailedDescription: String {
        LanguageManager.shared.s(detailedDescription)
    }

    var icon: String {
        switch self {
        case .darkness: return "moon.fill"
        case .veryDark: return "moon.stars.fill"
        case .dim: return "light.min"
        case .indoor: return "lamp.desk.fill"
        case .brightIndoor: return "light.max"
        case .overcast: return "cloud.fill"
        case .daylight: return "sun.max.fill"
        case .directSun: return "sun.max.trianglebadge.exclamationmark.fill"
        }
    }

    var color: Color {
        switch self {
        case .darkness: return .indigo
        case .veryDark: return .purple
        case .dim: return .blue
        case .indoor: return .cyan
        case .brightIndoor: return .green
        case .overcast: return .mint
        case .daylight: return .yellow
        case .directSun: return .orange
        }
    }

    var range: ClosedRange<Double> {
        switch self {
        case .darkness: return 0...1
        case .veryDark: return 1...50
        case .dim: return 50...200
        case .indoor: return 200...500
        case .brightIndoor: return 500...1000
        case .overcast: return 1000...10000
        case .daylight: return 10000...25000
        case .directSun: return 25000...150000
        }
    }
}
