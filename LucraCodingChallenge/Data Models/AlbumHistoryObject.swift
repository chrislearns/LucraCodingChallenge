//
//  AlbumHistoryObject.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftData
import SwiftUI

@Model
class AlbumHistoryObject {
    var id: UUID
    var searchDate: Date
    var object: Album
    
    init(searchDate: Date = Date(), object: Album) {
        self.searchDate = searchDate
        self.object = object
        self.id = UUID()
    }
}

