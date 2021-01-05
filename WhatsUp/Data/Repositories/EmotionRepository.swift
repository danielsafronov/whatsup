//
//  EmotionRepository.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation
import CoreData
import Combine

protocol EmotionRepositoryProtocol {
    func getEmotions() -> [Emotion]
    func saveEmotion(name: String) -> Void
}

struct EmotionRepository: EmotionRepositoryProtocol {
    let context: NSManagedObjectContext
    
    func getEmotions() -> [Emotion] {
        let request: NSFetchRequest<Emotion> = Emotion.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func saveEmotion(name: String) -> Void {
        let entry = Emotion(context: context)
        entry.id = UUID()
        entry.index = Int64(0)
        entry.name = name
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print(nsError.localizedDescription)
        }
    }
}

struct DefaultEmotionRepository: EmotionRepositoryProtocol {
    func getEmotions() -> [Emotion] {
        return []
    }
    
    func saveEmotion(name: String) {}
}

struct PreviewEmotionRepository: EmotionRepositoryProtocol {
    func getEmotions() -> [Emotion] {
        return []
    }
    
    func saveEmotion(name: String) {}
}
