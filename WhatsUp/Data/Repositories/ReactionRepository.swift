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
    func observeReactions(context: NSManagedObjectContext) -> AnyPublisher<[Reaction], Error>
    func saveReaction(reaction: ReactionMO, in context: NSManagedObjectContext) -> Void
}

struct ReactionRepository: ReactionRepositoryProtocol {
    let store: Store
    
    func observeReactions(context: NSManagedObjectContext) -> AnyPublisher<[Reaction], Error> {
        return store.observe(ReactionMO.fetchRequest(), in: context)
        .map { objects in
            objects.compactMap { object in
                Reaction(mo: object)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveReaction(reaction: ReactionMO, in context: NSManagedObjectContext) {
        store.store(reaction, in: context)
    }
}

struct DefaultReactionRepository: ReactionRepositoryProtocol {
    func observeReactions(context: NSManagedObjectContext) -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveReaction(reaction: ReactionMO, in context: NSManagedObjectContext) { }
}

struct PreviewReactionRepository: ReactionRepositoryProtocol {
    func observeReactions(context: NSManagedObjectContext) -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveReaction(reaction: ReactionMO, in context: NSManagedObjectContext) { }
}
