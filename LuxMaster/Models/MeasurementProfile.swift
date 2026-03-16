import Foundation

enum MeasurementProfile: String, CaseIterable, Identifiable, Codable {
    case general = "Allgemein"
    case office = "Büro"
    case photography = "Fotografie"
    case greenhouse = "Gewächshaus"
    case outdoor = "Außen"

    var id: String { rawValue }

    var localizedName: String {
        LanguageManager.shared.s(rawValue)
    }

    var recommendedRange: ClosedRange<Double> {
        switch self {
        case .general: return 200...500
        case .office: return 300...500
        case .photography: return 100...1000
        case .greenhouse: return 5000...30000
        case .outdoor: return 1000...100000
        }
    }

    var description: String {
        switch self {
        case .general: return "Allgemeine Lichtmessung"
        case .office: return "Arbeitsplatzbeleuchtung (300-500 Lux empfohlen)"
        case .photography: return "Belichtungsmessung für Fotografie"
        case .greenhouse: return "Pflanzenlicht-Messung"
        case .outdoor: return "Außenmessung / Tageslicht"
        }
    }

    var localizedDescription: String {
        LanguageManager.shared.s(description)
    }

    var icon: String {
        switch self {
        case .general: return "light.max"
        case .office: return "desktopcomputer"
        case .photography: return "camera.fill"
        case .greenhouse: return "leaf.fill"
        case .outdoor: return "sun.max.fill"
        }
    }
}
