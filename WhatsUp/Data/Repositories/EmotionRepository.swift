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
    func observeEmotions() -> AnyPublisher<[Emotion], Error>
    func saveEmotion(entry: Emotion) -> Void
    func deleteEmotion(entry: Emotion) -> Void
}

struct EmotionRepository: EmotionRepositoryProtocol {
    let store: Store
    
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return store.observe(EmotionMO.fetchRequest())
        .map { objects in
            objects.compactMap { object in
                Emotion(mo: object)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion) -> Void {
        store.store(EmotionMO(context: store.context, entry: entry))
    }
    
    func deleteEmotion(entry: Emotion) {
        let request: NSFetchRequest<EmotionMO> = EmotionMO.fetchRequest()
        request.predicate = NSPredicate.init(format: "id == %@", NSUUID(uuidString: entry.id.uuidString)!)
        request.fetchLimit = 1
        
        guard let entity = store.find(request) else { return }
        store.delete(entity)
    }
}

struct DefaultEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion) {}
    
    func deleteEmotion(entry: Emotion) { }
}

struct PreviewEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion) {}
    
    func deleteEmotion(entry: Emotion) { }
}
