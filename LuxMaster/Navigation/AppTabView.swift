import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        TabView {
            MeasurementView()
                .tabItem {
                    Label(lang.s("Messen"), systemImage: "camera.metering.spot")
                }

            HistoryListView()
                .tabItem {
                    Label(lang.s("Verlauf"), systemImage: "clock.arrow.circlepath")
                }

            SettingsView()
                .tabItem {
                    Label(lang.s("Einstellungen"), systemImage: "gearshape")
                }
        }
    }
}
