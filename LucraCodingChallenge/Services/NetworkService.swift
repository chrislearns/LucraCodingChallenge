//
//  NetworkService.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

class NetworkService {
    func fetchAlbums(query: String) async -> Result<[Album], LucraDemoError> {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/search/?q_all=\(query)&q_type=album") else {
            return .failure(.invalidURL)
        }
        
        struct ReturnObject: Codable {
            var data: [Album]
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID 2d086962f60c89e", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ReturnObject.self, from: data)
            return .success(response.data)
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
    
    func fetchImages(albumId: String) async -> Result<[ImgurImage], LucraDemoError> {
        guard let url = URL(string: "https://api.imgur.com/3/album/\(albumId)/images") else {
            return .failure(.invalidURL)
        }
        
        struct ReturnObject: Codable {
            var data: [ImgurImage]
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID 2d086962f60c89e", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ReturnObject.self, from: data)
            return .success(response.data)
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
}
