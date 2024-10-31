//
//  NewStack.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct NewStack<Content: View>: View {
    init(navigationPathContainer: NavigationPathContainer = .init(),
         @ViewBuilder content: @escaping (NavigationPathContainer) -> Content) {
        _navigationPathContainer = .init(wrappedValue: navigationPathContainer)
        self.content = content
    }
    
    @StateObject var navigationPathContainer: NavigationPathContainer
    @ViewBuilder var content: (NavigationPathContainer) -> Content
    
    var body: some View {
        NavigationStack(path: $navigationPathContainer.navigationPath) {
            content(navigationPathContainer)
                .navigationDestination(for: LucraDemoNavigationDestination.self) { destination in
                    LucraDemoDestinationView(navigationPathContainer: navigationPathContainer, destination: destination)
                }
                .preferredColorScheme(.dark)
        }
        .environmentObject(navigationPathContainer)
    }
}
