//
//  Application.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation
import CoreData

protocol ApplicationProtocol {
    var container: Container { get }
}

struct Application: ApplicationProtocol {
    var container: Container
}

extension Application {
    static var bootstrap: Self {
        let context = getContext()
        let store = getStore(context: context)
        let interactors = getInteractors(store: store)
        let container = Container(interactors: interactors)
        
        return Application(container: container)
    }
    
    private static func getContext() -> NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    private static func getStore(context: NSManagedObjectContext) -> Store {
        return Store(context: context)
    }
    
    private static func getInteractors(store: Store) -> InteractorsProtocol {
        let emotionRepository = getEmotionRepository(store: store)
        let emotionInteractor = getEmotionInteractor(repository: emotionRepository)
        
        let reactionRepository = getReactionRepository(store: store)
        let reactionInteractor = getReactionInteractor(repository: reactionRepository)
        
        return Interactors(
            emotion: emotionInteractor,
            reaction: reactionInteractor
        )
    }
    
    private static func getEmotionInteractor(repository: EmotionRepositoryProtocol) -> EmotionInteractorProtocol {
        return EmotionInteractor(repository: repository)
    }
    
    private static func getEmotionRepository(store: Store) -> EmotionRepositoryProtocol {
        return EmotionRepository(store: store)
    }
    
    private static func getReactionInteractor(repository: ReactionRepositoryProtocol) -> ReactionInteractorProtocol {
        return ReactionInteractor(repository: repository)
    }
    
    private static func getReactionRepository(store: Store) -> ReactionRepositoryProtocol {
        return ReactionRepository(store: store)
    }
}

extension Application {
    static var preview: Self {
        .init(container: .preview)
    }
}
