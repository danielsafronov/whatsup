//
//  ReactionRepository.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 05.01.2021.
//

import Foundation
import Combine
import CoreData

protocol ReactionRepositoryProtocol {
    func observeReactions() -> AnyPublisher<[Reaction], Error>
}

struct ReactionRepository: ReactionRepositoryProtocol {
    let store: Store
    
    func observeReactions() -> AnyPublisher<[Reaction], Error> {
        return store.observe(ReactionMO.fetchRequest())
        .map { objects in
            objects.compactMap { object in
                Reaction(mo: object)
            }
        }
        .eraseToAnyPublisher()
    }
}

struct DefaultReactionRepository: ReactionRepositoryProtocol {
    func observeReactions() -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct PreviewReactionRepository: ReactionRepositoryProtocol {
    func observeReactions() -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
