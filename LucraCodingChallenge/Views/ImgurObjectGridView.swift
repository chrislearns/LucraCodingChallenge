//
//  ImgurObjectGridView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct ImgurObjectGridView<VM: ImgurObjectGridViewProvider>: View {
    @StateObject var viewModel: VM
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 60), spacing: 5), count: 4)) {
                ForEach(viewModel.queryResults) { object in
                    PresentationButton(presentationMode: .sheet(detents: [.large])) { _ in
                        NewStack { _ in
                            ImgurObjectViewerView(imgurObject: object)
                        }
                    } buttonContent: {
                        ImgurObjectThumbnailView(imgurObject: object)
                    }
                }
            }
        }
        .navigationTitle(viewModel.title)
    }
}
