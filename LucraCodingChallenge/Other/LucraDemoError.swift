//
//  LucraDemoError.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

enum LucraDemoError: Error, LocalizedError {
    case invalidURL
    case failedToGetVideoThumbnail
    case decodingError
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .decodingError:
            return "Failed to decode the response."
        case .failedToGetVideoThumbnail:
            return "Failed to get video thumbnail"
        case .networkError(let message):
            return message
        }
    }
}
