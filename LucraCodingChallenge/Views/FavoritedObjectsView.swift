//
//  FavoritedObjectsView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import SwiftData

struct FavoritedObjectsView: View {
    @Environment(\.modelContext) private var context
    @Query private var savedItems: [SavedObject]
    
    var body: some View {
        Group {
            if savedItems.isEmpty {
                ContentUnavailableView("Empty",
                                       systemImage: "heart.slash")
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 60), spacing: 5), count: 4)) {
                        ForEach(savedItems) { object in
                            PresentationButton(presentationMode: .sheet(detents: [.large])) { _ in
                                NewStack { _ in
                                    ImgurObjectViewerView(imgurObject: object.object)
                                }
                            } buttonContent: {
                                ImgurObjectThumbnailView(imgurObject: object.object)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
