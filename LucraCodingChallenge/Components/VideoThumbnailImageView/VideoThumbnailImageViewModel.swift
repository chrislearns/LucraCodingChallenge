//
//  VideoThumbnailImageViewModel.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import AVKit

class VideoThumbnailImageViewModel: ObservableObject {
    init(videoURL: URL?) {
        self.videoURL = videoURL
        createThumbnailOfVideoFromRemoteUrl(url: videoURL)
    }
    
    let videoURL: URL?
    @Published var queryStatus: OutputStatus<UIImage, LucraDemoError> = .processing
    
    //Credit to https://stackoverflow.com/questions/31779150/creating-thumbnail-from-local-video-in-swift
    func createThumbnailOfVideoFromRemoteUrl(url: URL?) {
        guard let url else {
            
            return
        }
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            Task { @MainActor in
                queryStatus = .success(thumbnail)
            }
        } catch {
            return queryStatus = .error(.failedToGetVideoThumbnail)
        }
    }
}
