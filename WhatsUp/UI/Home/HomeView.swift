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
    @StateObject var model = HomeViewModel()
    
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
                            EmotionView(title: emotion.name!)
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: ReactionsView()) {
                        Text("Reactions")
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
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Emotion")
        let sort = NSSortDescriptor(key: "index", ascending: false)
        request.sortDescriptors = [sort]
        
        var emotions: [Emotion] = []
        
        do {
            emotions = try context.fetch(request) as! [Emotion]
        } catch {
            print(error.localizedDescription)
        }
        
        let model = HomeViewModel()
        model.emotions = emotions
        
        return HomeView(model: model)
            .environment(\.managedObjectContext, context)
    }
}
