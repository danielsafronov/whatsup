//
//  EmotionsView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 02.01.2021.
//

import SwiftUI
import Combine
import CoreData

struct EmotionsView: View {
    @ObservedObject private(set) var model: EmotionsViewModel

    var body: some View {
        List {
            ForEach(model.emotions) { emotion in
                EmotionRowView(
                    emotion: emotion,
                    onChange: { emotion in
                        model.update(emotion: emotion)
                    }
                )
            }
            .onDelete(perform: model.delete)
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $model.isCreateSheetPresented) {
            NavigationView {
                EmotionCreateView(
                    model: .init(
                        container: model.container,
                        isPresented: $model.isCreateSheetPresented
                    )
                )
            }
        }
        .navigationBarTitle("Emotions", displayMode: .inline)
        .navigationBarItems(
            trailing:
                Button(
                    "Add",
                    action: { model.isCreateSheetPresented.toggle() }
                )
        )
    }
}

struct EmotionsView_Previews: PreviewProvider {
    static var previews: some View {
        let container: Container = .preview
        let emotion = Emotion(
            id: UUID(),
            index: 0,
            isPinned: true,
            name: "🙂"
        )
        let model = EmotionsViewModel(container: container)
        model.emotions = [emotion]
        
        return EmotionsView(model: model)
    }
}
