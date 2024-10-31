//
//  Album.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct Album: Codable, Identifiable, Equatable, Hashable {
    var id: String
    var title: String
    var datetime: Int
    var cover: String?
    var cover_width: Int?
    var cover_height: Int?
    var account_url: String?
    var account_id: Int?
    var privacy: String
    var layout: String
    var views: Int
    var link: String
    var favorite: Bool
    var nsfw: Bool?
    var section: String?
    var order: Int?
    var deletehash: String?
    var images_count: Int?
    var images: [ImgurImage]?
    var in_gallery: Bool
}
