//
//  LucraDemoDestinationView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

enum LucraDemoNavigationDestination: NavigationDestinationProtocol {
    case albumView(album: Album)
    case favoritesView
    case historyView
}

struct LucraDemoDestinationView: View {
    let navigationPathContainer: NavigationPathContainer
    let destination: LucraDemoNavigationDestination
    var body: some View {
        switch destination {
        case .albumView(let album):
            ImgurObjectGridView(viewModel: AlbumViewModel(album: album, navigationPathContainer: navigationPathContainer))
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        OptionalView(value: URL(string: album.link)) { url in
                            Link(destination: url) {
                                Image(systemName: "safari")
                            }
                        }
                    }
                }
        case .favoritesView:
            FavoritedObjectsView()
        case .historyView:
            AlbumHistoryView()
        }
    }
}
