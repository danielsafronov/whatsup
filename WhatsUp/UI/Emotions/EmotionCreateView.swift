//
//  EmotionCreateView.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 02.01.2021.
//

import SwiftUI
import Combine
import CoreData

struct EmotionCreateView: View {
    @ObservedObject private(set) var model: EmotionCreateViewModel
    
    var body: some View {
        List {
            TextField("Enter custom emotion here...", text: $model.name)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("New Emotion", displayMode: .inline)
        .navigationBarItems(
            leading: Button("Cancel", action: { model.close() }),
            trailing: Button(
                "Save",
                action: {
                    model.save()
                    model.clear()
                    model.close()
                }
            )
        )
    }
}

struct EmotionCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionCreateView(
            model: .init(
                container: .preview,
                isPresented: Binding.constant(true)
            )
        )
    }
}
