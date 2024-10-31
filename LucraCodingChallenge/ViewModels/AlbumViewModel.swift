//
//  AlbumViewModel.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

class AlbumViewModel: ImgurObjectGridViewProvider {
    @Published var queryStatus: OutputStatus<[ImgurImage], LucraDemoError> = .processing
    let album: Album
    let navigationPathContainer: NavigationPathContainer
    
    private let networkService: NetworkService
    
    var title: String { album.title }
    
    var queryResults: [ImgurImage] {
        switch queryStatus {
        case .success(let value):
            return value
        default:
            return []
        }
    }
    
    init(album: Album,
         navigationPathContainer: NavigationPathContainer,
         networkService: NetworkService = NetworkService()) {
        self.album = album
        self.networkService = networkService
        self.navigationPathContainer = navigationPathContainer
        Task {
            await fetchImages()
        }
    }
    
    func fetchImages() async {
        await MainActor.run {
            queryStatus = .processing
        }
        let result = await networkService.fetchImages(albumId: album.id)
        if !Task.isCancelled {
            await MainActor.run {
                switch result {
                case .success(let images):
                    self.queryStatus = .success(images)
                case .failure(let error):
                    self.queryStatus = .error(error)
                }
            }
        }
    }
}
