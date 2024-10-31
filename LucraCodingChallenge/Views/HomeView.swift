//
//  HomeView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct HomeView: View {
    
    init(navigationPathContainer: NavigationPathContainer) {
        _viewModel = .init(wrappedValue: .init(navigationPathContainer: navigationPathContainer))
    }
    @StateObject private var viewModel: HomeViewModel
    @Environment(\.modelContext) private var context
    var body: some View {
        VStack {
            List(viewModel.queryResults) { album in
                Button {
                    context.insert(AlbumHistoryObject(object: album))
                    viewModel.navigationPathContainer.navigationPath.append(LucraDemoNavigationDestination.albumView(album: album))
                } label: {
                    VStack(alignment: .leading) {
                        Text(album.title)
                            .font(.headline)
                        if let imagesCount = album.images_count {
                            Text("\(imagesCount) Images")
                                .font(.subheadline)
                        }
                        Text("Views: \(album.views)")
                            .font(.footnote)
                    }
                    .padding()
                }
            }
            .navigationTitle("ImGuru")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.searchingInProgress = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    
                }
            }
            .overlay {
                if viewModel.queryResults.isEmpty {
                    switch viewModel.queryStatus {
                    case .success:
                        if viewModel.query.isEmpty {
                            if viewModel.searchingInProgress {
                                ContentUnavailableView("Begin Searching",
                                                       systemImage: "magnifyingglass")
                            } else {
                                ScrollView {
                                    VStack(spacing: 20){
                                        NavigationLink(value: LucraDemoNavigationDestination.favoritesView) {
                                            homeCard(systemImage: "heart.fill",
                                                     title: "Favorites",
                                                     color: Color(red: 0.9, green: 0.3, blue: 0.5))
                                        }
                                        NavigationLink(value: LucraDemoNavigationDestination.historyView) {
                                            homeCard(systemImage: "clock.arrow.circlepath",
                                                     title: "Album History",
                                                     color: Color(red: 0.2, green: 0.3, blue: 0.5))
                                        }
                                    }
                                }
                            }
                        } else {
                            ContentUnavailableView.search(text: viewModel.query)
                        }
                    case .processing:
                        ProgressView()
                    case .error(let error):
                        ContentUnavailableView("Content Unavailable",
                                               systemImage: "photo.on.rectangle.angled",
                                               description: Text("Error: \(error.localizedDescription)"))
                    }
                }
            }
            .searchable (text: $viewModel.query, isPresented: $viewModel.searchingInProgress, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
    
    func homeCard(systemImage: String,
                  title: String,
                  color: Color) -> some View {
        HStack(spacing: 45){
            Image(systemName: systemImage)
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(height: 80)
        .background(
            ZStack {
                Color(white: 0.1)
                SkewedRectangle(topFraction: 1, bottomFraction: 0.7)
                    .frame(width: 90)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(color)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}
