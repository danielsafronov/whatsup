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
    
    var body: some View {
        let name = emotion?.name
        
        HStack {
            VStack(alignment: .leading) {
                Text(name ?? "")
            }
            
            Spacer()
        }
    }
}

struct EmotionRowView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            EmotionRowView(
                emotion: .init(id: UUID(), index: 0, name: "🙂")
            )
            EmotionRowView()
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
