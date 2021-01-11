//
//  EmotionCreateViewModel.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 04.01.2021.
//

import Foundation
import Combine
import SwiftUI

class EmotionCreateViewModel: ObservableObject {
    @Published var name: String = ""
    
    private let isPresented: Binding<Bool>
    private let container: Container
    
    init(container: Container, isPresented: Binding<Bool>) {
        self.container = container
        self.isPresented = isPresented
    }
    
    func close() {
        isPresented.wrappedValue = false
    }
    
    func clear() {
        name = ""
    }
    
    func save() {
        container.interactors.emotion.saveEmotion(
            emotion: .init(
                id: UUID(),
                index: 0,
                isPinned: true,
                name: name
            )
        )
    }
}
