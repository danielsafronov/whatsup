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
    func getReactions() -> [Reaction]
}

struct ReactionRepository: ReactionRepositoryProtocol {
    let context: NSManagedObjectContext
    
    func getReactions() -> [Reaction] {
        let request: NSFetchRequest<Reaction> = Reaction.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct DefaultReactionRepository: ReactionRepositoryProtocol {
    func getReactions() -> [Reaction] {
        return []
    }
}

struct PreviewReactionRepository: ReactionRepositoryProtocol {
    func getReactions() -> [Reaction] {
        return []
    }
}
