//
//  EmotionsViewModel.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 04.01.2021.
//

import Foundation
import Combine

class EmotionsViewModel: ObservableObject {
    @Published var isCreateSheetPresented: Bool = false
    @Published var emotions: [Emotion] = []
    
    let container: Container
    
    init(container: Container) {
        self.container = container
        self.emotions = getEmotions()
    }
    
    private func getEmotions() -> [Emotion] {
        return container.interactors.emotion.getEmotions()
    }
}
