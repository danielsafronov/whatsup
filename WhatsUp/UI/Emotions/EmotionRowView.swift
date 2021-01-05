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
        let context = PersistenceController.preview.container.viewContext
        let request: NSFetchRequest<Emotion> = Emotion.fetchRequest()
        request.fetchLimit = 1
        
        var emotions: [Emotion] = []
        
        do {
            emotions = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return Group {
            EmotionRowView(emotion: emotions.first)
            EmotionRowView()
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
