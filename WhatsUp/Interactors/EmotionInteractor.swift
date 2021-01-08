//
//  EmotionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation
import Combine

protocol EmotionInteractorProtocol {
    func observeEmotions() -> AnyPublisher<[Emotion], Error>
    func saveEmotion(name: String) -> Void
    func deleteEmotion(emotion: Emotion) -> Void
}

struct EmotionInteractor: EmotionInteractorProtocol {
    let repository: EmotionRepositoryProtocol
    
    func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return repository.observeEmotions()
    }
    
    func saveEmotion(name: String) -> Void {
        repository.saveEmotion(name: name)
    }
    
    func deleteEmotion(emotion: Emotion) {
        repository.deleteEmotion(emotion: emotion)
    }
}

extension EmotionInteractor {
    static var `default`: Self {
        .init(repository: DefaultEmotionRepository())
    }
    
    static var preview: Self {
        .init(repository: PreviewEmotionRepository())
    }
}
