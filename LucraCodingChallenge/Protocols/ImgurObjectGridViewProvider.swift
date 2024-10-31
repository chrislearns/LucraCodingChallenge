//
//  ImgurObjectGridViewProvider.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

protocol ImgurObjectGridViewProvider: ObservableObject {
    var queryResults: [ImgurImage] { get }
    var title: String { get }
}
