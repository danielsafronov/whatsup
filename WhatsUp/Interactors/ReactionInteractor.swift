//
//  ReactionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 05.01.2021.
//

import Foundation
import Combine

protocol ReactionInteractorProtocol {
    func getReactions() -> [Reaction]
}

struct ReactionInteractor: ReactionInteractorProtocol {
    let repository: ReactionRepositoryProtocol
    
    func getReactions() -> [Reaction] {
        return repository.getReactions()
    }
}

extension ReactionInteractor {
    static var `default`: Self {
        .init(repository: DefaultReactionRepository())
    }
    
    static var preview: Self {
        .init(repository: PreviewReactionRepository())
    }
}
