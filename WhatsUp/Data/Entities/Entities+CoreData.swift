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
        let isPinned = mo.isPinned
        guard let name = mo.name else { return nil }
        
        self.init(id: id, index: index, isPinned: isPinned, name: name)
    }
}

extension EmotionMO {
    convenience init(context: NSManagedObjectContext, entry: Emotion) {
        self.init(context: context)
        
        id = entry.id
        index = Int64(entry.index)
        isPinned = entry.isPinned
        name = entry.name
    }
    
    static func fetchPinnedRequest() -> NSFetchRequest<EmotionMO> {
        let request: NSFetchRequest<EmotionMO> = EmotionMO.fetchRequest()
        request.predicate = NSPredicate.init(format: "isPinned == %@", NSNumber(value: true))
        
        return request
    }
    
    static func fetchOneByIdRequest(id: UUID) -> NSFetchRequest<EmotionMO> {
        let request: NSFetchRequest<EmotionMO> = EmotionMO.fetchRequest()
        request.predicate = NSPredicate.init(format: "id == %@", NSUUID(uuidString: id.uuidString)!)
        request.fetchLimit = 1
        
        return request
    }
}

extension Reaction {
    init?(mo: ReactionMO) {
        guard let id = mo.id else { return nil }
        guard let emotionId = mo.emotionId else { return nil }
        guard let timestamp = mo.timestamp else { return nil }
        guard let emotionMO = mo.emotion else { return nil }
        guard let emotion = Emotion(mo: emotionMO) else { return nil }
        
        self.init(
            id: id,
            emotionId: emotionId,
            timestamp: timestamp,
            emotion: emotion
        )
    }
}

extension ReactionMO {
    convenience init(context: NSManagedObjectContext, entry: Reaction) {
        self.init(context: context)
        
        id = entry.id
        emotionId = entry.emotionId
        timestamp = entry.timestamp
        emotion = EmotionMO(context: context, entry: entry.emotion)
    }
}
