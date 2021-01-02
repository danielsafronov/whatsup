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
    @StateObject var model = ReactionsViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(model.reactions) { reaction in
                    ReactionRowView(reaction: reaction)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(
            Text("Reactions"),
            displayMode: .inline
        )
    }
}

struct ReactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reaction")
        
        var reactions: [Reaction] = []
        
        do {
            reactions = try context.fetch(request) as! [Reaction]
        } catch {
            print(error.localizedDescription)
        }
        
        let model = ReactionsViewModel()
        model.reactions = reactions
        
        return Group {
            ReactionsView(model: model)
                .environment(\.colorScheme, .light)
            
            ReactionsView(model: model)
                .environment(\.colorScheme, .dark)
        }
    }
}
