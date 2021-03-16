//
//  EmotionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation
import Combine
import CoreData

protocol EmotionInteractorProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error>
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error>
    func saveEmotion(emotion: Emotion)
    func deleteEmotion(emotion: Emotion)
    func updateEmotion(emotion: Emotion)
}

struct EmotionInteractor: EmotionInteractorProtocol {
    let observeEmotionsInteractor: ObserveEmotionsInteractorProtocol
    let observePinnedEmotionsInteractor: ObservePinnedEmotionsInteractorProtocol
    let saveEmotionInteractor: SaveEmotionInteractorProtocol
    let deleteEmotionInteractor: DeleteEmotionInteractorProtocol
    let updateEmotionInteractor: UpdateEmotionInteractorProtocol
    
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return observeEmotionsInteractor.invoke()
    }
    
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error> {
        return observePinnedEmotionsInteractor.invoke()
    }
    
    func saveEmotion(emotion: Emotion) {
        saveEmotionInteractor.invoke(entry: emotion)
    }
    
    func deleteEmotion(emotion: Emotion) {
        deleteEmotionInteractor.invoke(entry: emotion)
    }
    
    func updateEmotion(emotion: Emotion) {
        updateEmotionInteractor.invoke(entry: emotion)
    }
}

extension EmotionInteractor {
    static var `default`: Self {
        .init(
            observeEmotionsInteractor: DefaultObserveEmotionsInteractor(),
            observePinnedEmotionsInteractor: DefaultObservePinnedEmotionsInteractor(),
            saveEmotionInteractor: DefaultSaveEmotionInteractor(),
            deleteEmotionInteractor: DefaultDeleteEmotionInteractor(),
            updateEmotionInteractor: DefaultUpdateEmotionInteractor()
        )
    }
    
    static var preview: Self {
        .init(
            observeEmotionsInteractor: PreviewObserveEmotionsInteractor(),
            observePinnedEmotionsInteractor: PreviewObservePinnedEmotionsInteractor(),
            saveEmotionInteractor: PreviewSaveEmotionInteractor(),
            deleteEmotionInteractor: PreviewDeleteEmotionInteractor(),
            updateEmotionInteractor: PreviewUpdateEmotionInteractor()
        )
    }
}

// MARK: - Observe Emotions Interactor
protocol ObserveEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error>
}

struct ObserveEmotionsInteractor: ObserveEmotionsInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: EmotionRepositoryProtocol
    
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return repository.observeEmotions(context: context)
    }
}

struct DefaultObserveEmotionsInteractor: ObserveEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct PreviewObserveEmotionsInteractor: ObserveEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Observe Pinned Emotions Interactor
protocol ObservePinnedEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error>
}

struct ObservePinnedEmotionsInteractor: ObservePinnedEmotionsInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: EmotionRepositoryProtocol
    
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return repository.observePinnedEmotions(context: context)
    }
}

struct DefaultObservePinnedEmotionsInteractor: ObservePinnedEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct PreviewObservePinnedEmotionsInteractor: ObservePinnedEmotionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Emotion], Error> {
        return Just<[Emotion]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Save Emotion Interactor
protocol SaveEmotionInteractorProtocol {
    func invoke(entry: Emotion)
}

struct SaveEmotionInteractor: SaveEmotionInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: EmotionRepositoryProtocol
    
    func invoke(entry: Emotion) {
        repository.saveEmotion(entry: entry, in: context)
    }
}

struct DefaultSaveEmotionInteractor: SaveEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}

struct PreviewSaveEmotionInteractor: SaveEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}

// MARK: - Delete Emotion Interactor
protocol DeleteEmotionInteractorProtocol {
    func invoke(entry: Emotion)
}

struct DeleteEmotionInteractor: DeleteEmotionInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: EmotionRepositoryProtocol
    
    func invoke(entry: Emotion) {
        repository.deleteEmotion(entry: entry, in: context)
    }
}

struct DefaultDeleteEmotionInteractor: DeleteEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}

struct PreviewDeleteEmotionInteractor: DeleteEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}


// MARK: - Update Emotion Interactor
protocol UpdateEmotionInteractorProtocol {
    func invoke(entry: Emotion)
}

struct UpdateEmotionInteractor: UpdateEmotionInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: EmotionRepositoryProtocol
    
    func invoke(entry: Emotion) {
        repository.updateEmotion(entry: entry, in: context)
    }
}

struct DefaultUpdateEmotionInteractor: UpdateEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}

struct PreviewUpdateEmotionInteractor: UpdateEmotionInteractorProtocol {
    func invoke(entry: Emotion) {}
}
