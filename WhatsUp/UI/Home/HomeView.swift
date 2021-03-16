//
//  ContentView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 12.11.2020.
//

import SwiftUI
import Combine
import CoreData

struct HomeView: View {
    @ObservedObject private(set) var model: HomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                VStack() {
                    Text("Hey, What's Up?")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    HStack {
                        let emotions = model.emotions
                            .sorted(by: { $0.index > $1.index })
                        
                        ForEach(emotions) { emotion in
                            EmotionView(emotion: emotion) { emotion in
                                model.trackReaction(emotion: emotion)
                            }
                        }
                    }
                    .padding()
                    
                    Link(
                        destination: EmotionsView(
                            model: .init(container: model.container)
                        ),
                        label: "Emotions"
                    )
                    
                    Link(
                        destination: ReactionsView(
                            model: .init(container: model.container)
                        ),
                        label: "Reactions"
                    )
                }
            }
            .navigationBarHidden(true)
        }
    }
}

private struct Link<Destination>: View where Destination : View {
    let destination: Destination
    let label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .foregroundColor(
                    Color(
                        red: 134 / 255,
                        green: 104 / 255,
                        blue: 83 / 255
                    )
                )
                .textCase(.uppercase)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = HomeViewModel(container: .preview)
        return HomeView(model: model)
    }
}
