//
//  ReactionsViewModel.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 01.01.2021.
//

import Foundation
import Combine

class ReactionsViewModel: ObservableObject {
    @Published var reactions: [Reaction] = []
    
    let container: Container
    
    private var cancellableBag = Set<AnyCancellable>()
    
    init(container: Container) {
        self.container = container
        
        loadReactions()
    }
    
    private func loadReactions() {
        observeReactions()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {_ in },
                receiveValue: { [self] reactions in
                    self.reactions = reactions
                }
            )
            .store(in: &cancellableBag)
    }
    
    private func observeReactions() -> AnyPublisher<[Reaction], Error> {
        return container.interactors.reaction.observeReactions()
    }
}
