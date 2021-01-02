//
//  Emotion+CoreDataProperties.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 02.01.2021.
//
//

import Foundation
import CoreData


extension Emotion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emotion> {
        return NSFetchRequest<Emotion>(entityName: "Emotion")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var index: Int64
    @NSManaged public var name: String?
    @NSManaged public var reactions: NSSet?

}

// MARK: Generated accessors for reactions
extension Emotion {

    @objc(addReactionsObject:)
    @NSManaged public func addToReactions(_ value: Reaction)

    @objc(removeReactionsObject:)
    @NSManaged public func removeFromReactions(_ value: Reaction)

    @objc(addReactions:)
    @NSManaged public func addToReactions(_ values: NSSet)

    @objc(removeReactions:)
    @NSManaged public func removeFromReactions(_ values: NSSet)

}

extension Emotion : Identifiable {

}
