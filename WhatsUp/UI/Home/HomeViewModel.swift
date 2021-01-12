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
}
