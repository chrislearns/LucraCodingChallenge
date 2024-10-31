//
//  HistoryView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//
import SwiftUI
import SwiftData

struct AlbumHistoryView: View {
    @Environment(\.modelContext) private var context
    @Query private var historyItems: [AlbumHistoryObject]
    
    var body: some View {
        Group {
            if historyItems.isEmpty {
                ContentUnavailableView("Empty",
                                       systemImage: "clock.arrow.circlepath")
            } else {
                Form {
                    List(historyItems) {
                        NavigationLink($0.object.title, value: LucraDemoNavigationDestination.albumView(album: $0.object))
                    }
                }
            }
        }
        .navigationTitle("Album History")
    }
}
