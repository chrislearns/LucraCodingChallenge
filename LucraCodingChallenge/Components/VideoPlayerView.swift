//
//  VideoPlayerView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import AVKit

class VideoPlayerViewModel: ObservableObject {
    
    init(url: URL) {
        self.player = .init(url: url)
        self.player.play()
    }
    
    var player: AVPlayer
}
    
struct VideoPlayerView: View {
    init(url: URL) {
        _viewModel = .init(wrappedValue: .init(url: url))
    }
    @StateObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        VideoPlayer(player: viewModel.player)
            .onDisappear {
                viewModel.player.pause()
            }
    }
}

