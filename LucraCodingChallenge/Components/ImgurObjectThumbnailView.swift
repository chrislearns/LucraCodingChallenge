//
//  ImgurObjectThumbnailView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct ImgurObjectThumbnailView: View {
    var imgurObject: ImgurImage
    var body: some View {
        switch imgurObject.isVideo {
        case true:
            VideoThumbnailImageView(videoURL: URL(string: imgurObject.link))
        case false:
            AsyncImage(url: URL(string: imgurObject.link)) { phase in
                switch phase {
                case .empty:
                    Color.black
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                case .failure:
                    Color(white: 0.1)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                        .overlay {
                            Image(systemName: imgurObject.placeholderSystemImage)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .foregroundStyle(Color(white: 0.8))
                        }
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
