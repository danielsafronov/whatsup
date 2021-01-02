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
}
