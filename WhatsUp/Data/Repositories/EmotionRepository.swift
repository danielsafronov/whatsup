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
    func saveEmotion(name: String) -> Void
    func deleteEmotion(emotion: Emotion) -> Void
}

struct EmotionRepository: EmotionRepositoryProtocol {
    let store: Store
    
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return store.fetch { _ in
            Emotion.fetchRequest()
        }
    }
    
    func saveEmotion(name: String) -> Void {
        store.store { context in
            let entry = Emotion(context: context)
            entry.id = UUID()
            entry.index = Int64(0)
            entry.name = name
        }
    }
    
    func deleteEmotion(emotion: Emotion) {
        store.delete { context in
            context.delete(emotion)
        }
    }
}

struct DefaultEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(name: String) {}
    
    func deleteEmotion(emotion: Emotion) { }
}

struct PreviewEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(name: String) {}
    
    func deleteEmotion(emotion: Emotion) { }
}
