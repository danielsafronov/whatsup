//
//  EmotionRowView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 02.01.2021.
//

import SwiftUI
import CoreData

struct EmotionRowView: View {
    var emotion: Emotion? = nil
    var onChange: ((Emotion) -> Void)? = nil
    
    var body: some View {
        let name = emotion?.name
        
        HStack {
            VStack(alignment: .leading) {
                Text(name ?? "")
            }
            
            Spacer()
            
            Button(
                action: {
                    if (emotion != nil) {
                        onChange?(
                            .init(
                                id: emotion!.id,
                                index: emotion!.index,
                                isPinned: !emotion!.isPinned,
                                name: emotion!.name
                            )
                        )
                    }
                }
            ) {
                if (emotion?.isPinned == true) {
                    Image(systemName: "pin.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                } else {
                    Image(systemName: "pin")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct EmotionRowView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            EmotionRowView(
                emotion: .init(
                    id: UUID(),
                    index: 0,
                    isPinned: true,
                    name: "🙂"
                )
            )
            EmotionRowView()
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
