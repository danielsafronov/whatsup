//
//  Container.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 03.01.2021.
//

import Foundation
import SwiftUI

struct Container: EnvironmentKey {
    let interactors: InteractorsProtocol
    
    init(interactors: InteractorsProtocol) {
        self.interactors = interactors
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(interactors: Interactors.default)
}

extension Container {
    static var preview: Self {
        .init(interactors: Interactors.preview)
    }
}

extension EnvironmentValues {
    var container: Container {
        get { self[Container.self] }
        set { self[Container.self] = newValue }
    }
}
