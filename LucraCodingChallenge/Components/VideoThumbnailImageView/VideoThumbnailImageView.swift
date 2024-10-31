//
//  VideoThumbnailImageView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import AVKit

struct VideoThumbnailImageView: View {
    
    init(videoURL: URL?) {
        _viewModel = .init(wrappedValue: .init(videoURL: videoURL))
    }
    
    @StateObject var viewModel: VideoThumbnailImageViewModel
    var body: some View {
        switch viewModel.queryStatus {
        case .success(let value):
            Image(uiImage: value)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
        case .processing:
            Color.black
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .overlay {
                    ProgressView()
                }
        case .error:
            Color(white: 0.1)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .overlay {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
        }
    }
}
