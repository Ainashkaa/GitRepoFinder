//
//  UserSearchManager.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import Foundation


class UserSearch: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func resetSearch() {
        users = []
        currentPage = 1
        canLoadMorePages = true
        isLoading = false
    }
    
    func markUserAsViewed(withId id: Int) {
        // Logic to mark a user as viewed
    }
    
    @MainActor
    func searchUsers(query: String, isNewSearch: Bool = true) async {
        guard !isLoading && canLoadMorePages else { return }
        
        if isNewSearch {
            resetSearch()
        }
        
        isLoading = true
        
//        ?q=rus&sort=followers&order=desc&per_page=30&page=1
        let urlString = "https://api.github.com/search/users?q=\(query)&sort=followers&order=desc&per_page=30&page=1"
      
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let searchResults = try JSONDecoder().decode(SearchResults<User>.self, from: data)
            
            await MainActor.run {
                if isNewSearch {
                    self.users = searchResults.items
                } else {
                    users.append(contentsOf: searchResults.items)
                }
                
                isLoading = false
                
                if searchResults.items.count < 30 {
                    canLoadMorePages = false
                } else {
                    currentPage += 1
                }
                
            }
        } catch {
            await MainActor.run  {
                self.isLoading = false
                self.canLoadMorePages = false
            }
        }
    }
}

