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
    func observeEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error>
    func observePinnedEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error>
    func saveEmotion(entry: Emotion, in context: NSManagedObjectContext) -> Void
    func deleteEmotion(entry: Emotion, in context: NSManagedObjectContext) -> Void
    func updateEmotion(entry: Emotion, in context: NSManagedObjectContext) -> Void
    func fetchEmotion(id: UUID, in context: NSManagedObjectContext) -> EmotionMO?
}

struct EmotionRepository: EmotionRepositoryProtocol {
    let store: Store
    
    func observeEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return store.observe(EmotionMO.fetchRequest(), in: context)
        .map { objects in
            objects.compactMap { object in
                Emotion(mo: object)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func observePinnedEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return store.observe(EmotionMO.fetchPinnedRequest(), in: context)
        .map { objects in
            objects.compactMap { object in
                Emotion(mo: object)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion, in context: NSManagedObjectContext) -> Void {
        store.store(EmotionMO(context: context, entry: entry), in: context)
    }
    
    func deleteEmotion(entry: Emotion, in context: NSManagedObjectContext) {
        let request = EmotionMO.fetchOneByIdRequest(id: entry.id)
        guard let entity = store.find(request, in: context) else { return }
        
        store.delete(entity, in: context)
    }
    
    func updateEmotion(entry: Emotion, in context: NSManagedObjectContext) -> Void {
        let request = EmotionMO.fetchOneByIdRequest(id: entry.id)
        guard let entity = store.find(request, in: context) else { return }
        
        entity.name = entry.name
        entity.isPinned = entry.isPinned
        
        store.update(entity, in: context)
    }
    
    func fetchEmotion(id: UUID, in context: NSManagedObjectContext) -> EmotionMO? {
        let request = EmotionMO.fetchOneByIdRequest(id: id)
        guard let entity = store.find(request, in: context) else { return nil }
        
        return entity
    }
}

struct DefaultEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func observePinnedEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func deleteEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func updateEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func fetchEmotion(id: UUID, in context: NSManagedObjectContext) -> EmotionMO? {
        return nil
    }
}

struct PreviewEmotionRepository: EmotionRepositoryProtocol {
    func observeEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func observePinnedEmotions(context: NSManagedObjectContext) -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func deleteEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func updateEmotion(entry: Emotion, in context: NSManagedObjectContext) { }
    
    func fetchEmotion(id: UUID, in context: NSManagedObjectContext) -> EmotionMO? {
        return nil
    }
}
