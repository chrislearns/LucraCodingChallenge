//
//  ImgurObjectViewerView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import AVKit
import SwiftData

struct ImgurObjectViewerView: View {
    @Environment(\.modelContext) private var context
    @Query private var savedItems: [SavedObject]
    
    init(imgurObject: ImgurImage) {
        _viewModel = .init(wrappedValue: .init(imgurObject: imgurObject))
    }
    
    var savedInstanceOfItem: SavedObject? {
        savedItems.first(where: {$0.object.id == viewModel.imgurObject.id})
    }
    
    @StateObject var viewModel: ImgurObjectViewerViewModel
    
    var body: some View {
        if let url = URL(string: viewModel.imgurObject.link) {
            Group {
                switch viewModel.imgurObject.isVideo {
                case false:
                    PhotoViewerView(url: url)
                case true:
                    VideoPlayerView(url: url)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let savedInstanceOfItem {
                            context.delete(savedInstanceOfItem)
                        } else {
                            context.insert(SavedObject(object: viewModel.imgurObject))
                        }
                        
                        do {
                            try context.save()
                        } catch {
                            UIApplication.showAlert(title: "Failed to save", message: "Please try again later")
                        }
                    } label: {
                        Image(systemName: savedInstanceOfItem == nil ? "heart" : "heart.fill")
                    }
                }
            }
        } else {
            ContentUnavailableView("",
                                   systemImage: "photo.on.rectangle.angled",
                                   description: Text("There was an issue loading this media"))
        }
    }
}
