//
//  Persistence.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 12.11.2020.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        for (index, title) in ["🙂", "😐", "🙁"].enumerated() {
            let emotion = Emotion(context: context)
            emotion.id = UUID()
            emotion.index = Int64(index)
            emotion.name = title
            
            let reaction = Reaction(context: context)
            reaction.id = UUID()
            reaction.emotion_id = emotion.id
            reaction.emotion = emotion
            reaction.timestamp = Date()
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WhatsUp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
