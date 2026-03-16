import Combine
import Foundation

@MainActor
class CalibrationManager: ObservableObject {
    static let shared = CalibrationManager()

    @Published var activeProfile: CalibrationProfile?
    @Published var profiles: [CalibrationProfile] = []

    private let storageKey = "calibrationProfiles"
    private let activeProfileKey = "activeCalibrationProfileID"

    init() {
        loadProfiles()
    }

    func createProfile(referenceValue: Double, measuredValue: Double) -> CalibrationProfile {
        let profile = CalibrationProfile(
            deviceModel: DeviceInfo.modelIdentifier,
            referenceValue: referenceValue,
            measuredValue: measuredValue
        )

        for i in profiles.indices {
            if profiles[i].deviceModel == profile.deviceModel {
                profiles[i].isActive = false
            }
        }

        profiles.append(profile)
        activeProfile = profile
        saveProfiles()
        return profile
    }

    func createMultiPointProfile(points: [CalibrationPoint]) -> CalibrationProfile {
        let profile = CalibrationProfile(
            deviceModel: DeviceInfo.modelIdentifier,
            points: points
        )

        for i in profiles.indices {
            if profiles[i].deviceModel == profile.deviceModel {
                profiles[i].isActive = false
            }
        }

        profiles.append(profile)
        activeProfile = profile
        saveProfiles()
        return profile
    }

    func activateProfile(_ profile: CalibrationProfile) {
        for i in profiles.indices {
            profiles[i].isActive = (profiles[i].id == profile.id)
        }
        activeProfile = profiles.first { $0.id == profile.id }
        saveProfiles()
    }

    func deleteProfile(_ profile: CalibrationProfile) {
        profiles.removeAll { $0.id == profile.id }
        if activeProfile?.id == profile.id {
            activeProfile = nil
        }
        saveProfiles()
    }

    var isCalibrated: Bool {
        activeProfile != nil
    }

    private func loadProfiles() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([CalibrationProfile].self, from: data)
        else { return }

        profiles = decoded
        if let activeID = UserDefaults.standard.string(forKey: activeProfileKey),
           let uuid = UUID(uuidString: activeID) {
            activeProfile = profiles.first { $0.id == uuid && $0.isActive }
        }
    }

    private func saveProfiles() {
        guard let data = try? JSONEncoder().encode(profiles) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
        if let activeID = activeProfile?.id {
            UserDefaults.standard.set(activeID.uuidString, forKey: activeProfileKey)
        } else {
            UserDefaults.standard.removeObject(forKey: activeProfileKey)
        }
    }
}
