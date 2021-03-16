//
//  ReactionsView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 30.12.2020.
//

import SwiftUI
import Combine
import CoreData

struct ReactionsView: View {
    @ObservedObject private(set) var model: ReactionsViewModel
    
    var body: some View {
        List {
            ForEach(model.reactions) { reaction in
                ReactionRowView(reaction: reaction)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Reactions", displayMode: .inline)
    }
}

struct ReactionsView_Previews: PreviewProvider {
    static var previews: some View {
        return ReactionsView(model: .init(container: .preview))
    }
}
