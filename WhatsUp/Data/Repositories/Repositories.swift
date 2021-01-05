//
//  Repositories.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation

protocol RepositoriesProtocol {
    var emotions: EmotionRepositoryProtocol { get }
    var reactions: ReactionRepositoryProtocol { get }
}

struct Repositories: RepositoriesProtocol {
    var emotions: EmotionRepositoryProtocol
    var reactions: ReactionRepositoryProtocol
}

extension Repositories {
    static var preview: Self {
        .init(
            emotions: PreviewEmotionRepository(),
            reactions: PreviewReactionRepository()
        )
    }
    
    static var `default`: Self {
        .init(
            emotions: DefaultEmotionRepository(),
            reactions: DefaultReactionRepository()
        )
    }
}
