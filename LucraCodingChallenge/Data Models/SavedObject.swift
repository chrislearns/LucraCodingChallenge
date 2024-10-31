//
//  SavedObject.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import SwiftData

@Model
class SavedObject {
    var id: UUID
    var saveDate: Date
    var object: ImgurImage
    
    init(saveDate: Date = Date(), object: ImgurImage) {
        self.saveDate = saveDate
        self.object = object
        self.id = UUID()
    }
}
