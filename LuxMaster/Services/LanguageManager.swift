import Combine
import Foundation
import SwiftUI

@MainActor
class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    struct Language: Identifiable, Hashable {
        let code: String
        let name: String
        let flag: String
        var id: String { code }
    }

    static let supportedLanguages: [Language] = [
        Language(code: "de", name: "Deutsch", flag: "🇩🇪"),
        Language(code: "en", name: "English", flag: "🇬🇧"),
        Language(code: "fr", name: "Français", flag: "🇫🇷"),
        Language(code: "es", name: "Español", flag: "🇪🇸"),
        Language(code: "it", name: "Italiano", flag: "🇮🇹"),
        Language(code: "pt", name: "Português", flag: "🇵🇹"),
        Language(code: "zh-Hans", name: "中文", flag: "🇨🇳"),
        Language(code: "ja", name: "日本語", flag: "🇯🇵")
    ]

    @Published var currentLanguage: String {
        didSet { UserDefaults.standard.set(currentLanguage, forKey: "appLanguage") }
    }

    private init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "de"
    }

    /// Returns the localized string for the given German key.
    func s(_ key: String) -> String {
        if currentLanguage == "de" { return key }
        return Translations.data[key]?[currentLanguage] ?? key
    }

    /// Returns the localized format string with arguments applied.
    func s(_ key: String, _ args: CVarArg...) -> String {
        let format = s(key)
        return String(format: format, arguments: args)
    }
}
