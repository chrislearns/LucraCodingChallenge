//
//  ImgurObjectViewerViewModel.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

class ImgurObjectViewerViewModel: ObservableObject {
    init(imgurObject: ImgurImage) {
        self.imgurObject = imgurObject
    }
    var imgurObject: ImgurImage
}
