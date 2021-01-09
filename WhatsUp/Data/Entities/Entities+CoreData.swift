//
//  Entities+CoreData.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 09.01.2021.
//

import Foundation
import CoreData

extension Emotion {
    init?(mo: EmotionMO) {
        guard let id = mo.id else { return nil }
        let index = Int(mo.index)
        guard let name = mo.name else { return nil }
        
        self.init(id: id, index: index, name: name)
    }
}

extension EmotionMO {
    convenience init(context: NSManagedObjectContext, entry: Emotion) {
        self.init(context: context)
        
        id = entry.id
        index = Int64(entry.index)
        name = entry.name
    }
}

extension Reaction {
    init?(mo: ReactionMO) {
        guard let id = mo.id else { return nil }
        guard let emotionId = mo.emotionId else { return nil }
        guard let timestamp = mo.timestamp else { return nil }
        
        self.init(id: id, emotionId: emotionId, timestamp: timestamp)
    }
}

extension ReactionMO {
    convenience init(context: NSManagedObjectContext, entry: Reaction) {
        self.init(context: context)
        
        id = entry.id
        emotionId = entry.emotionId
        timestamp = entry.timestamp
    }
}
