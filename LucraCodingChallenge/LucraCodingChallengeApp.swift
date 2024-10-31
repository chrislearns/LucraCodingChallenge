//
//  LucraCodingChallengeApp.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/30/24.
//

import SwiftUI
import SwiftData

@main
struct LucraCodingChallengeApp: App {
    
    var container: ModelContainer

       init() {
           do {
               container = try ModelContainer(for: SavedObject.self, AlbumHistoryObject.self)
           } catch {
               fatalError("Failed to configure SwiftData container.")
           }
       }

    var body: some Scene {
        WindowGroup {
            NewStack { navigationPathContainer in
                HomeView(navigationPathContainer: navigationPathContainer)
            }
        }
        .modelContainer(container)
    }
}
