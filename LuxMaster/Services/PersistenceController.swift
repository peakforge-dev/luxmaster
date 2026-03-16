import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        for i in 0..<10 {
            let measurement = LuxMeasurement(context: viewContext)
            measurement.id = UUID()
            measurement.luxValue = Double.random(in: 50...5000)
            measurement.timestamp = Date().addingTimeInterval(Double(-i * 3600))
            measurement.note = i % 3 == 0 ? "Testmessung \(i + 1)" : nil
            measurement.profileName = MeasurementProfile.allCases.randomElement()?.rawValue
        }
        try? viewContext.save()
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LuxMaster")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("CoreData Fehler: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func saveMeasurement(
        luxValue: Double,
        note: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        locationName: String? = nil,
        profileName: String? = nil,
        iso: Double = 0,
        exposureDuration: Double = 0
    ) throws {
        let context = container.viewContext
        let measurement = LuxMeasurement(context: context)
        measurement.id = UUID()
        measurement.luxValue = luxValue
        measurement.timestamp = Date()
        measurement.note = note
        measurement.latitude = latitude ?? 0
        measurement.longitude = longitude ?? 0
        measurement.locationName = locationName
        measurement.profileName = profileName
        measurement.iso = iso
        measurement.exposureDuration = exposureDuration
        measurement.deviceModel = DeviceInfo.modelIdentifier
        try context.save()
    }

    func deleteMeasurement(_ measurement: LuxMeasurement) throws {
        let context = container.viewContext
        context.delete(measurement)
        try context.save()
    }

    func deleteAllMeasurements() throws {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LuxMeasurement")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        try context.save()
    }
}

enum DeviceInfo {
    static var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce("") { result, element in
            guard let value = element.value as? Int8, value != 0 else { return result }
            return result + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
