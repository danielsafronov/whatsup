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
        let name = reaction?.emotion.name ?? ""
        let date = reaction?.timestamp
        
        HStack {
            VStack(alignment: .leading) {
                Text(name)
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
        return Group {
            ReactionRowView(
                reaction: .init(
                    id: UUID(),
                    timestamp: Date(),
                    emotion: .init(
                        id: UUID(),
                        index: 0,
                        isPinned: true,
                        name: "🙂"
                    )
                )
            )
            ReactionRowView()
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
