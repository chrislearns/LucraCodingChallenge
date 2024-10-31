//
//  PhotoViewerView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct PhotoViewerView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    @State private var offset: CGSize = .zero
    @State private var zoom: CGFloat = 1.0
    
    let url: URL
    
    var body: some View {
        ZoomableScrollView {
            AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.black
                        ProgressView()
                            .tint(.white)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    ZStack {
                        Color.black
                        Text(error.localizedDescription)
                            .foregroundStyle(.white)
                    }
                @unknown default:
                    EmptyView()
                }
            }
        }.background(Color.black)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .tint(.white)
                }
            }
    }
}
