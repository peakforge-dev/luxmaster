import Foundation

enum AppConstants {
    static let appName = "LuxMaster"

    // Lux Calculation
    static let calibrationConstantK: Double = 12.5
    static let defaultAperture: Float = 1.8
    static let measurementSmoothingWindow: Int = 10
    static let frameProcessingInterval: Int = 5

    // Export
    static let csvDateFormat = "yyyy-MM-dd HH:mm:ss"
    static let pdfTitle = "LuxMaster Messbericht"
    static let pdfRowsPerPage = 30

    // UI
    static let luxDisplayFontSize: CGFloat = 72
    static let luxAnimationDuration: Double = 0.3
}
