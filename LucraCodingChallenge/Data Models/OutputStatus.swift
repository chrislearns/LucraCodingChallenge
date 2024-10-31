//
//  OutputStatus.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

enum OutputStatus<Value, Error> {
    case success(Value)
    case processing
    case error(Error)
}
