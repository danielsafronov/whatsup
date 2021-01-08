//
//  ReactionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 05.01.2021.
//

import Foundation
import Combine

protocol ReactionInteractorProtocol {
    func observeReactions() -> AnyPublisher<[Reaction], Error>
}

struct ReactionInteractor: ReactionInteractorProtocol {
    let repository: ReactionRepositoryProtocol
    
    func observeReactions() -> AnyPublisher<[Reaction], Error> {
        return repository.observeReactions()
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
