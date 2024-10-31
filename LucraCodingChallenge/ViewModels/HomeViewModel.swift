//
//  HomeViewModel.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var queryStatus: OutputStatus<[Album], LucraDemoError> = .processing
    @Published var query: String = ""
    @Published var searchingInProgress = false
    
    let navigationPathContainer: NavigationPathContainer
    
    private var cancellable: AnyCancellable?
    private var currentTask: Task<(), Never>?
    private let networkService: NetworkService
    
    var queryResults: [Album] {
        switch queryStatus {
        case .success(let value):
            return value
        default:
            return []
        }
    }
    
    init(networkService: NetworkService = NetworkService(),
         navigationPathContainer: NavigationPathContainer) {
        self.navigationPathContainer = navigationPathContainer
        self.networkService = networkService
        cancellable = $query
            .removeDuplicates()
            .sink { newQuery in
                self.currentTask?.cancel()
                self.currentTask = Task {
                    await self.fetchData(query: newQuery)
                }
            }
    }
    
    func fetchData(query: String) async {
        await MainActor.run {
            queryStatus = .processing
        }
        let result = await networkService.fetchAlbums(query: query)
        if !Task.isCancelled {
            await MainActor.run {
                switch result {
                case .success(let albums):
                    self.queryStatus = .success(albums)
                case .failure(let error):
                    self.queryStatus = .error(error)
                }
            }
        }
    }
}
