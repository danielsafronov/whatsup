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
}
