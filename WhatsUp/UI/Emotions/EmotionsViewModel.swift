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
    
    private var cancellableBag = Set<AnyCancellable>()
    
    init(container: Container) {
        self.container = container
        
        loadEmotions()
    }
    
    private func loadEmotions() {
        observeEmotions()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {_ in },
                receiveValue: { [self] emotions in
                    self.emotions = emotions
                }
            )
            .store(in: &cancellableBag)
    }
    
    private func observeEmotions() -> AnyPublisher<[Emotion], Error> {
        return container.interactors.emotion.observeEmotions()
    }
    
    func delete(at offsets: IndexSet) -> Void {
        for index in offsets {
            let emotion = emotions[index]
            delete(emotion: emotion)
        }
    }
    
    private func delete(emotion: Emotion) -> Void {
        container.interactors.emotion.deleteEmotion(emotion: emotion)
    }
}
