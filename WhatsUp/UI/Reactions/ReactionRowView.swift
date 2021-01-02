//
//  ReactionItemView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 30.12.2020.
//

import SwiftUI
import CoreData

struct ReactionRowView: View {
    var reaction: Reaction? = nil
    
    var body: some View {
        let name = reaction?.emotion?.name
        let date = reaction?.timestamp
        
        HStack {
            VStack(alignment: .leading) {
                Text(name ?? "")
            }
            
            Spacer()
            
            if date != nil {
                Text(date ?? Date(), formatter: dateFormatter)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ReactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reaction")
        request.fetchLimit = 1
        
        var reactions: [Reaction] = []
        
        do {
            reactions = try context.fetch(request) as! [Reaction]
        } catch {
            print(error.localizedDescription)
        }
        
        return Group {
            ReactionRowView(reaction: reactions[0])
            ReactionRowView()
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
