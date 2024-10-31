//
//  ImgurImage.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct ImgurImage: Codable, Identifiable, Equatable, Hashable {
    var id: String
    var title: String?
    var datetime: Int
    var type: String?
    var animated: Bool?
    var width: Int?
    var height: Int?
    var size: Int?
    var views: Int?
    var bandwidth: Int?
    var deletehash: String?
    var name: String?
    var section: String?
    var link: String
    var gifv: String?
    var mp4: String?
    var mp4_size: Int?
    var looping: Bool?
    var favorite: Bool
    var nsfw: Bool?
    var vote: String?
    var in_gallery: Bool
    
    var isVideo: Bool {
        type?.split(separator: "/").first?.lowercased() == "video"
    }
    
    var placeholderSystemImage: String {
        isVideo ? "video" : "photo"
    }
}
