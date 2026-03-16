import Foundation

extension Date {
    var formattedShort: String {
        formatted(date: .abbreviated, time: .shortened)
    }

    var formattedLong: String {
        formatted(date: .long, time: .standard)
    }

    var formattedCSV: String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.csvDateFormat
        formatter.locale = Locale(identifier: "de_DE")
        return formatter.string(from: self)
    }

    var formattedRelative: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
