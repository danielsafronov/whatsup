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
        let interactors = getInteractors(context: context)
        let container = Container(interactors: interactors)
        
        return Application(container: container)
    }
    
    private static func getContext() -> NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    private static func getInteractors(context: NSManagedObjectContext) -> InteractorsProtocol {
        let emotionRepository = getEmotionRepository(context: context)
        let emotionInteractor = getEmotionInteractor(repository: emotionRepository)
        
        let reactionRepository = getReactionRepository(context: context)
        let reactionInteractor = getReactionInteractor(repository: reactionRepository)
        
        return Interactors(
            emotion: emotionInteractor,
            reaction: reactionInteractor
        )
    }
    
    private static func getEmotionInteractor(repository: EmotionRepositoryProtocol) -> EmotionInteractorProtocol {
        return EmotionInteractor(repository: repository)
    }
    
    private static func getEmotionRepository(context: NSManagedObjectContext) -> EmotionRepositoryProtocol {
        return EmotionRepository(context: context)
    }
    
    private static func getReactionInteractor(repository: ReactionRepositoryProtocol) -> ReactionInteractorProtocol {
        return ReactionInteractor(repository: repository)
    }
    
    private static func getReactionRepository(context: NSManagedObjectContext) -> ReactionRepositoryProtocol {
        return ReactionRepository(context: context)
    }
}

extension Application {
    static var preview: Self {
        .init(container: .preview)
    }
}
