import Foundation

struct CalibrationPoint: Codable, Equatable {
    var referenceValue: Double
    var measuredValue: Double
}

struct CalibrationProfile: Codable, Identifiable, Equatable {
    let id: UUID
    var deviceModel: String
    var calibrationFactor: Double
    var calibrationOffset: Double
    var referenceValue: Double
    var measuredValue: Double
    var calibrationDate: Date
    var isActive: Bool
    var calibrationPoints: [CalibrationPoint]

    // Single-point init (backward compatible)
    init(
        id: UUID = UUID(),
        deviceModel: String,
        referenceValue: Double,
        measuredValue: Double,
        calibrationDate: Date = Date()
    ) {
        self.id = id
        self.deviceModel = deviceModel
        self.referenceValue = referenceValue
        self.measuredValue = measuredValue
        self.calibrationDate = calibrationDate
        self.isActive = true
        self.calibrationPoints = [CalibrationPoint(referenceValue: referenceValue, measuredValue: measuredValue)]

        if measuredValue > 0 {
            self.calibrationFactor = referenceValue / measuredValue
            self.calibrationOffset = 0
        } else {
            self.calibrationFactor = 1.0
            self.calibrationOffset = 0
        }
    }

    // Multi-point init
    init(
        id: UUID = UUID(),
        deviceModel: String,
        points: [CalibrationPoint],
        calibrationDate: Date = Date()
    ) {
        self.id = id
        self.deviceModel = deviceModel
        self.calibrationDate = calibrationDate
        self.isActive = true
        self.calibrationPoints = points.sorted { $0.measuredValue < $1.measuredValue }

        if let first = points.first, first.measuredValue > 0 {
            self.referenceValue = first.referenceValue
            self.measuredValue = first.measuredValue
            self.calibrationFactor = first.referenceValue / first.measuredValue
        } else {
            self.referenceValue = 0
            self.measuredValue = 0
            self.calibrationFactor = 1.0
        }
        self.calibrationOffset = 0
    }

    // Custom decoder for backward compatibility with stored profiles
    enum CodingKeys: String, CodingKey {
        case id, deviceModel, calibrationFactor, calibrationOffset
        case referenceValue, measuredValue, calibrationDate, isActive
        case calibrationPoints
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        deviceModel = try container.decode(String.self, forKey: .deviceModel)
        calibrationFactor = try container.decode(Double.self, forKey: .calibrationFactor)
        calibrationOffset = try container.decode(Double.self, forKey: .calibrationOffset)
        referenceValue = try container.decode(Double.self, forKey: .referenceValue)
        measuredValue = try container.decode(Double.self, forKey: .measuredValue)
        calibrationDate = try container.decode(Date.self, forKey: .calibrationDate)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        calibrationPoints = try container.decodeIfPresent([CalibrationPoint].self, forKey: .calibrationPoints)
            ?? [CalibrationPoint(referenceValue: referenceValue, measuredValue: measuredValue)]
    }

    /// Piecewise linear interpolation for multi-point calibration.
    /// Falls back to single factor for 1-point profiles.
    func applyCalibration(rawLux: Double) -> Double {
        let points = calibrationPoints.sorted { $0.measuredValue < $1.measuredValue }

        guard !points.isEmpty else {
            return rawLux * calibrationFactor + calibrationOffset
        }

        if points.count == 1 {
            let factor = points[0].measuredValue > 0 ? points[0].referenceValue / points[0].measuredValue : 1.0
            return rawLux * factor
        }

        // Below lowest point: extrapolate from first segment
        if rawLux <= points[0].measuredValue {
            return interpolate(rawLux: rawLux, p0: points[0], p1: points[1])
        }

        // Above highest point: extrapolate from last segment
        if rawLux >= points[points.count - 1].measuredValue {
            return interpolate(rawLux: rawLux, p0: points[points.count - 2], p1: points[points.count - 1])
        }

        // Between two points: piecewise linear
        for i in 0 ..< (points.count - 1) {
            if rawLux >= points[i].measuredValue && rawLux <= points[i + 1].measuredValue {
                return interpolate(rawLux: rawLux, p0: points[i], p1: points[i + 1])
            }
        }

        return rawLux * calibrationFactor
    }

    private func interpolate(rawLux: Double, p0: CalibrationPoint, p1: CalibrationPoint) -> Double {
        let range = p1.measuredValue - p0.measuredValue
        guard range > 0 else { return p0.referenceValue }
        let t = (rawLux - p0.measuredValue) / range
        return p0.referenceValue + t * (p1.referenceValue - p0.referenceValue)
    }
}
