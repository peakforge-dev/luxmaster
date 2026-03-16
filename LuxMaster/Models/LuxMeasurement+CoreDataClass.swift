import Foundation
import CoreData

@objc(LuxMeasurement)
public class LuxMeasurement: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        if id == nil { id = UUID() }
        if timestamp == nil { timestamp = Date() }
    }

    var luxRange: LuxRange {
        LuxRange.from(lux: luxValue)
    }

    var hasLocation: Bool {
        latitude != 0 || longitude != 0
    }

    var profile: MeasurementProfile? {
        guard let name = profileName else { return nil }
        return MeasurementProfile(rawValue: name)
    }

    var formattedExposure: String {
        if exposureDuration > 0 {
            let denominator = Int(1.0 / exposureDuration)
            return "1/\(denominator)s"
        }
        return "-"
    }
}
