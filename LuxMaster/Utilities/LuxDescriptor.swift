import Foundation

enum LuxDescriptor {
    static func describe(_ lux: Double) -> String {
        let lang = LanguageManager.shared
        switch lux {
        case ..<1: return lang.s("Nahezu vollständige Dunkelheit")
        case 1..<10: return lang.s("Entspricht: Vollmondnacht")
        case 10..<50: return lang.s("Entspricht: Straßenbeleuchtung")
        case 50..<100: return lang.s("Entspricht: Wohnzimmer, gedimmt")
        case 100..<200: return lang.s("Entspricht: Flur, Treppenhaus")
        case 200..<300: return lang.s("Entspricht: Wohnraum, normal")
        case 300..<500: return lang.s("Entspricht: Büro-Arbeitsplatz")
        case 500..<750: return lang.s("Entspricht: gut beleuchteter Arbeitsplatz")
        case 750..<1000: return lang.s("Entspricht: Zeichenarbeitsplatz")
        case 1000..<5000: return lang.s("Entspricht: bewölkter Tag")
        case 5000..<10000: return lang.s("Entspricht: bedeckter Himmel")
        case 10000..<25000: return lang.s("Entspricht: Tageslicht, Schatten")
        case 25000..<50000: return lang.s("Entspricht: helles Tageslicht")
        case 50000..<100000: return lang.s("Entspricht: Sonnenlicht")
        default: return lang.s("Entspricht: direktes Sonnenlicht")
        }
    }

    static func isWithinRecommended(_ lux: Double, profile: MeasurementProfile) -> Bool {
        profile.recommendedRange.contains(lux)
    }

    static func recommendation(for lux: Double, profile: MeasurementProfile) -> String? {
        let lang = LanguageManager.shared
        let range = profile.recommendedRange
        if lux < range.lowerBound {
            return lang.s("Zu dunkel für %@ (min. %d Lux empfohlen)", profile.localizedName, Int(range.lowerBound))
        } else if lux > range.upperBound {
            return lang.s("Zu hell für %@ (max. %d Lux empfohlen)", profile.localizedName, Int(range.upperBound))
        }
        return nil
    }
}
