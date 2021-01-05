//
//  EmotionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation

protocol EmotionInteractorProtocol {
    func getEmotions() -> [Emotion]
    func saveEmotion(name: String) -> Void
}

struct EmotionInteractor: EmotionInteractorProtocol {
    let repository: EmotionRepositoryProtocol
    
    func getEmotions() -> [Emotion] {
        return repository.getEmotions()
    }
    
    func saveEmotion(name: String) -> Void {
        repository.saveEmotion(name: name)
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
