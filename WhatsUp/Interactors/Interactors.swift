//
//  Interactors.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation

protocol InteractorsProtocol {
    var emotion: EmotionInteractorProtocol { get }
    var reaction: ReactionInteractorProtocol { get }
}

struct Interactors: InteractorsProtocol {
    var emotion: EmotionInteractorProtocol
    var reaction: ReactionInteractorProtocol
}

extension Interactors {
    static var `default`: Self {
        .init(
            emotion: EmotionInteractor.default,
            reaction: ReactionInteractor.default
        )
    }
}

extension Interactors {
    static var preview: Self {
        .init(
            emotion: EmotionInteractor.preview,
            reaction: ReactionInteractor.preview
        )
    }
}
