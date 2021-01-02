//
//  Reaction+CoreDataProperties.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 02.01.2021.
//
//

import Foundation
import CoreData


extension Reaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reaction> {
        return NSFetchRequest<Reaction>(entityName: "Reaction")
    }

    @NSManaged public var emotion_id: UUID?
    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var emotion: Emotion?

}

extension Reaction : Identifiable {

}
