//
//  EmotionView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 29.12.2020.
//

import SwiftUI

struct EmotionView: View {
    let title: String
    
    var body: some View {
        Text(self.title)
            .font(.body)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding()
            .background(
                Color(red: 215 / 255, green: 171 / 255, blue: 207 / 255)
            )
            .cornerRadius(5)
            .shadow(radius: 5)        
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(title: "Emotion Title")
    }
}
