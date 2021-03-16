//
//  EmotionView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 29.12.2020.
//

import SwiftUI

struct EmotionView: View {
    let emotion: Emotion
    let onClick: ((Emotion) -> Void)?
    
    init(emotion: Emotion, onClick: ((Emotion) -> Void)? = nil) {
        self.emotion = emotion
        self.onClick = onClick
    }
    
    var body: some View {
        Button(action: { self.onClick?(self.emotion)}) {
            Text(emotion.name)
                .font(.body)
                .fontWeight(.bold)
                .padding()
                .background(
                    Color(red: 215 / 255, green: 171 / 255, blue: 207 / 255)
                )
                .cornerRadius(5)
                .shadow(radius: 5)
        }
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(
            emotion: Emotion(
                id: UUID(),
                index: 0,
                isPinned: false,
                name: "🙂"
            )
        )
    }
}
