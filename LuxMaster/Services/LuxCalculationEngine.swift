import Foundation

struct LuxCalculationEngine {

    static func calculateLux(
        averageBrightness: Double,
        iso: Float,
        exposureDuration: Double,
        aperture: Float = AppConstants.defaultAperture,
        calibrationProfile: CalibrationProfile? = nil
    ) -> Double {
        guard exposureDuration > 0, iso > 0 else { return 0 }

        let apertureSquared = Double(aperture * aperture)
        let isoNormalized = Double(iso) / 100.0

        let rawLux = (averageBrightness * apertureSquared * AppConstants.calibrationConstantK)
            / (isoNormalized * exposureDuration)

        if let profile = calibrationProfile, profile.isActive {
            return max(0, profile.applyCalibration(rawLux: rawLux))
        }

        return max(0, rawLux)
    }

    static func calculateEV(
        iso: Float,
        exposureDuration: Double,
        aperture: Float = AppConstants.defaultAperture
    ) -> Double {
        guard exposureDuration > 0, iso > 0 else { return 0 }
        return log2(Double(aperture * aperture) / exposureDuration) - log2(Double(iso) / 100.0)
    }
}

class LuxSmoother: @unchecked Sendable {
    private var values: [Double] = []
    private let windowSize: Int
    private let trimFraction: Double = 0.2
    private let lock = NSLock()

    init(windowSize: Int = AppConstants.measurementSmoothingWindow) {
        self.windowSize = windowSize
    }

    func addValue(_ value: Double) -> Double {
        lock.lock()
        defer { lock.unlock() }
        values.append(value)
        if values.count > windowSize {
            values.removeFirst()
        }
        return _smoothedValue
    }

    var average: Double {
        lock.lock()
        defer { lock.unlock() }
        return _smoothedValue
    }

    /// Trimmed mean: sort, discard top/bottom 20%, average the rest.
    /// Falls back to simple average when window is too small to trim.
    private var _smoothedValue: Double {
        guard !values.isEmpty else { return 0 }
        let count = values.count
        let trimCount = Int(Double(count) * trimFraction)

        if count < 5 || trimCount == 0 {
            return values.reduce(0, +) / Double(count)
        }

        let sorted = values.sorted()
        let trimmed = sorted[trimCount ..< (count - trimCount)]
        return trimmed.reduce(0, +) / Double(trimmed.count)
    }

    var min: Double { lock.lock(); defer { lock.unlock() }; return values.min() ?? 0 }
    var max: Double { lock.lock(); defer { lock.unlock() }; return values.max() ?? 0 }

    var stability: Double {
        lock.lock()
        defer { lock.unlock() }
        let avg = _smoothedValue
        guard avg > 0, values.count > 1 else { return 0 }
        let variance = values.map { ($0 - avg) * ($0 - avg) }
            .reduce(0, +) / Double(values.count - 1)
        return Swift.max(0, 1.0 - (sqrt(variance) / avg))
    }

    func reset() {
        lock.lock()
        defer { lock.unlock() }
        values.removeAll()
    }
}
