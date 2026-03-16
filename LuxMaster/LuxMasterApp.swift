import CoreData
import SwiftUI

@main
struct LuxMasterApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var calibrationManager = CalibrationManager()
    @StateObject private var languageManager = LanguageManager.shared

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cameraManager)
                .environmentObject(calibrationManager)
                .environmentObject(languageManager)
                .onAppear {
                    cameraManager.calibrationProfile = calibrationManager.activeProfile
                }
        }
    }
}
