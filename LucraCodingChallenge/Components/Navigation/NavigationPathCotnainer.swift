//
//  NavigationPathCotnainer.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

class NavigationPathContainer: ObservableObject {
    init() { }
    let id = UUID()
    
    @Published var navigationPath: NavigationPath = .init()
    
    func appendNavigationPath(value: LucraDemoNavigationDestination) {
        self.navigationPath.append(value)
    }
    
    func removeAll() {
        self.navigationPath.removeLast(navigationPath.count)
    }
}

