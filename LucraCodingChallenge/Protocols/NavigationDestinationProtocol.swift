//
//  NavigationDestinationProtocol.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

protocol NavigationDestinationProtocol: Hashable, Identifiable { }

extension NavigationDestinationProtocol {
    var id: String { String(describing: self) }
}
