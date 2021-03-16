//
//  HomeViewModel.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 29.12.2020.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var emotions: [Emotion] = []
    
    let container: Container
    
    private var cancellableBag = Set<AnyCancellable>()
    
    init(container: Container) {
        self.container = container
        
        loadEmotions()
    }
    
    func loadEmotions() -> Void {
        observePinnedEmotions()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {_ in },
                receiveValue: { [self] emotions in
                    self.emotions = emotions
                }
            )
            .store(in: &cancellableBag)
    }
    
    func observePinnedEmotions() -> AnyPublisher<[Emotion], Error> {
        return container.interactors.emotion.observePinnedEmotions()
    }
    
    func trackReaction(emotion: Emotion) -> Void {
        let reaction = createReaction(emotion: emotion)
        container.interactors.reaction.saveReaction(reaction: reaction)
    }
    
    private func createReaction(emotion: Emotion) -> Reaction {
        return Reaction(id: UUID(), timestamp: Date(), emotion: emotion)
    }
}
