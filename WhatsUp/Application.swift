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
        let store = getStore()
        let interactors = getInteractors(store: store, context: context)
        let container = Container(interactors: interactors)
        
        return Application(container: container)
    }
    
    private static func getContext() -> NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    private static func getStore() -> Store {
        return Store()
    }
    
    private static func getInteractors(store: Store, context: NSManagedObjectContext) -> InteractorsProtocol {
        let emotionRepository = getEmotionRepository(store: store)
        let emotionInteractor = getEmotionInteractor(context: context, repository: emotionRepository)
        
        let reactionRepository = getReactionRepository(store: store)
        let reactionInteractor = getReactionInteractor(context: context, reactionRepository: reactionRepository, emotionRepository: emotionRepository)
        
        return Interactors(
            emotion: emotionInteractor,
            reaction: reactionInteractor
        )
    }
    
    private static func getEmotionRepository(store: Store) -> EmotionRepositoryProtocol {
        return EmotionRepository(store: store)
    }
    
    private static func getEmotionInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> EmotionInteractorProtocol {
        let observeEmotionsInteractor = getObserveEmotionsInteractor(context: context, repository: repository)
        let observePinnedEmotionsInteractor = getObservePinnedEmotionsInteractor(context: context, repository: repository)
        let saveEmotionInteractor = getSaveEmotionInteractor(context: context, repository: repository)
        let deleteEmotionInteractor = getDeleteEmotionInteractor(context: context, repository: repository)
        let updateEmotionInteractor = getUpdateEmotionInteractor(context: context, repository: repository)
        
        return EmotionInteractor(
            observeEmotionsInteractor: observeEmotionsInteractor,
            observePinnedEmotionsInteractor: observePinnedEmotionsInteractor,
            saveEmotionInteractor: saveEmotionInteractor,
            deleteEmotionInteractor: deleteEmotionInteractor,
            updateEmotionInteractor: updateEmotionInteractor
        )
    }
    
    private static func getObserveEmotionsInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> ObserveEmotionsInteractorProtocol {
        return ObserveEmotionsInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getObservePinnedEmotionsInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> ObservePinnedEmotionsInteractorProtocol {
        return ObservePinnedEmotionsInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getSaveEmotionInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> SaveEmotionInteractorProtocol {
        return SaveEmotionInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getDeleteEmotionInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> DeleteEmotionInteractorProtocol {
        return DeleteEmotionInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getUpdateEmotionInteractor(
        context: NSManagedObjectContext,
        repository: EmotionRepositoryProtocol
    ) -> UpdateEmotionInteractorProtocol {
        return UpdateEmotionInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getReactionInteractor(
        context: NSManagedObjectContext,
        reactionRepository: ReactionRepositoryProtocol,
        emotionRepository: EmotionRepositoryProtocol
    ) -> ReactionInteractorProtocol {
        let observeReactionsInteractor = getObserveReactionsInteractor(context: context, repository: reactionRepository)
        let saveReactionInteractor = getSaveReactionInteractor(context: context, reactionRepository: reactionRepository, emotionRepository: emotionRepository)
        
        return ReactionInteractor(
            observeReactionsInteractor: observeReactionsInteractor,
            saveReactionInteractor: saveReactionInteractor
        )
    }
    
    private static func getObserveReactionsInteractor(
        context: NSManagedObjectContext,
        repository: ReactionRepositoryProtocol
    ) -> ObserveReactionsInteractorProtocol {
        return ObserveReactionsInteractor(
            context: context,
            repository: repository
        )
    }
    
    private static func getSaveReactionInteractor(
        context: NSManagedObjectContext,
        reactionRepository: ReactionRepositoryProtocol,
        emotionRepository: EmotionRepositoryProtocol
    ) -> SaveReactionInteractorProtocol {
        return SaveReactionInteractor(
            context: context,
            reactionRepository: reactionRepository,
            emotionRepository: emotionRepository
        )
    }
    
    private static func getReactionRepository(
        store: Store
    ) -> ReactionRepositoryProtocol {
        return ReactionRepository(store: store)
    }
}

extension Application {
    static var preview: Self {
        .init(container: .preview)
    }
}
