//
//  RepositoryListViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation

class RepositoryListViewModel: ObservableObject {
    
    @Published var repositories: [Repository] = []
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    private var gitHubService: GitHubService
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
    }
    
    func resetSearch() {
        repositories = []
        currentPage = 1
        canLoadMorePages = true
        isLoadingPage = false
    }
    
    func markRepositoryAsViewed(withId id: Int) {
        if let index = repositories.firstIndex(where: { $0.id == id }) {
            repositories[index].isViewed = true
        }
    }
    
    @MainActor
    func searchRepositories(query: String, sortOption: SortOption? = nil, isNewSearch: Bool = true) async {
        guard !isLoadingPage && (isNewSearch || canLoadMorePages) else { return }

        isLoadingPage = true
        if isNewSearch { resetSearch() }

        let request = SearchRepositoriesRequest(query: query, sortOption: sortOption, page: currentPage)

        do {
            let searchResults = try await gitHubService.searchRepositories(request: request)
            if isNewSearch {
                repositories = searchResults.items
            } else {
                repositories.append(contentsOf: searchResults.items)
            }
            canLoadMorePages = searchResults.items.count == 30 
            currentPage += 1
        } catch {
            // Handle and present error information
        }

        isLoadingPage = false
    }
}
