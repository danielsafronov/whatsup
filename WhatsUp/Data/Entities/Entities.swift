//
//  Entities.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 09.01.2021.
//

import Foundation

struct Emotion: Identifiable, Codable, Equatable {
    let id: UUID
    let index: Int
    let isPinned: Bool
    let name: String
}

struct Reaction: Identifiable, Codable, Equatable  {
    let id: UUID
    let emotionId: UUID
    let timestamp: Date
    let emotion: Emotion
}
