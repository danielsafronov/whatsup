//
//  ReactionInteractor.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 05.01.2021.
//

import Foundation
import Combine
import CoreData

protocol ReactionInteractorProtocol {
    func observeReactions() -> AnyPublisher<[Reaction], Error>
    func saveReaction(reaction: Reaction) -> Void
}

struct ReactionInteractor: ReactionInteractorProtocol {
    let observeReactionsInteractor: ObserveReactionsInteractorProtocol
    let saveReactionInteractor: SaveReactionInteractorProtocol
    
    func observeReactions() -> AnyPublisher<[Reaction], Error> {
        observeReactionsInteractor.invoke()
    }
    
    func saveReaction(reaction: Reaction) {
        saveReactionInteractor.invoke(reaction: reaction)
    }
}

extension ReactionInteractor {
    static var `default`: Self {
        .init(
            observeReactionsInteractor: DefaultObserveReactionsInteractor(),
            saveReactionInteractor: DefaultSaveReactionInteractor()
        )
    }
    
    static var preview: Self {
        .init(
            observeReactionsInteractor: PreviewObserveReactionsInteractor(),
            saveReactionInteractor: PreviewSaveReactionInteractor()
        )
    }
}

// MARK: - Observe Reaction Interactor
protocol ObserveReactionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Reaction], Error>
}

struct ObserveReactionsInteractor: ObserveReactionsInteractorProtocol {
    let context: NSManagedObjectContext
    let repository: ReactionRepositoryProtocol
    
    func invoke() -> AnyPublisher<[Reaction], Error> {
        return repository.observeReactions(context: context)
    }
}

struct DefaultObserveReactionsInteractor: ObserveReactionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct PreviewObserveReactionsInteractor: ObserveReactionsInteractorProtocol {
    func invoke() -> AnyPublisher<[Reaction], Error> {
        return Just<[Reaction]>([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Save Reaction Interactor
protocol SaveReactionInteractorProtocol {
    func invoke(reaction: Reaction) -> Void
}

struct SaveReactionInteractor: SaveReactionInteractorProtocol {
    let context: NSManagedObjectContext
    let reactionRepository: ReactionRepositoryProtocol
    let emotionRepository: EmotionRepositoryProtocol
    
    func invoke(reaction: Reaction) {
        guard let emotionMO = emotionRepository.fetchEmotion(id: reaction.emotion.id, in: context) else { return }
        let reactionMO = ReactionMO(context: context, entry: reaction)
        reactionMO.emotion = emotionMO
        
        reactionRepository.saveReaction(reaction: reactionMO, in: context)
    }
}

struct DefaultSaveReactionInteractor: SaveReactionInteractorProtocol {
    func invoke(reaction: Reaction) {}
}

struct PreviewSaveReactionInteractor: SaveReactionInteractorProtocol {
    func invoke(reaction: Reaction) {}
}
