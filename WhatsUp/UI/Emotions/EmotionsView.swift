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
                EmotionRowView(emotion: emotion)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Emotions", displayMode: .inline)
        .navigationBarItems(
            trailing:
                Button(
                    "Add",
                    action: { model.isCreateSheetPresented.toggle() }
                )
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
        )
    }
}

struct EmotionsView_Previews: PreviewProvider {
    static var previews: some View {
        return EmotionsView(model: .init(container: .preview))
    }
}
