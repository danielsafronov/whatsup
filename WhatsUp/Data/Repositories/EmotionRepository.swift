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
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error>
    func saveEmotion(entry: Emotion) -> Void
    func deleteEmotion(entry: Emotion) -> Void
    func updateEmotion(entry: Emotion) -> Void
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
    
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error> {
        return store.observe(EmotionMO.fetchPinnedRequest())
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
        let request = EmotionMO.fetchOneByIdRequest(id: entry.id)
        guard let entity = store.find(request) else { return }
        
        store.delete(entity)
    }
    
    func updateEmotion(entry: Emotion) -> Void {
        let request = EmotionMO.fetchOneByIdRequest(id: entry.id)
        guard let entity = store.find(request) else { return }
        
        entity.name = entry.name
        entity.isPinned = entry.isPinned
        
        store.update(entity)
    }
}

struct DefaultEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion) { }
    
    func deleteEmotion(entry: Emotion) { }
    
    func updateEmotion(entry: Emotion) { }
}

struct PreviewEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion) { }
    
    func deleteEmotion(entry: Emotion) { }
    
    func updateEmotion(entry: Emotion) { }
}
