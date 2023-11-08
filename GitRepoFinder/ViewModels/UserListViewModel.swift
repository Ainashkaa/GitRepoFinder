//
//  UserListViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import Foundation

enum UsersSort: String {
    case followers = "followers"
}

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    private var gitHubService: GitHubService
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
    }
    
    func resetSearch() {
        users = []
        currentPage = 1
        canLoadMorePages = true
        isLoadingPage = false
    }
    
    @MainActor
    func searchUsers(query: String, sortOption: SortOption? = nil, isNewSearch: Bool = true) async {
        guard !isLoadingPage && (isNewSearch || canLoadMorePages) else { return }

        isLoadingPage = true
        if isNewSearch { resetSearch() }

        let request = SearchUsersRequest(query: query, sortOption: .followers, page: currentPage)

        do {
            let searchResults = try await gitHubService.searchUsers(request: request)
            if isNewSearch {
                users = searchResults.items
            } else {
                users.append(contentsOf: searchResults.items)
            }
            canLoadMorePages = searchResults.items.count == 30
            currentPage += 1
        } catch {
            // Handle and present error information
        }

        isLoadingPage = false
    }
}

