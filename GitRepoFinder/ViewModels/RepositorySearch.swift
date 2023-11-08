//
//  RepositorySearch.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation


class RepositorySearch: ObservableObject {
    
    @Published var repositories: [Repository] = []
    @Published var isLoadingPage = false
    var historyViewModel = HistoryManager()
    
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func resetSearch() {
        repositories = []
        currentPage = 1
        canLoadMorePages = true
        isLoadingPage = false
    }
    
    func markRepositoryAsViewed(withId id: Int) {
        guard let index = repositories.firstIndex(where: { $0.id == id }) else { return }
        repositories[index].isViewed = true
        // Add the repository to the history
        // Trigger UI update if necessary
        self.repositories = repositories.map { $0 }
    }
    
    @MainActor
    func searchRepositories(query: String, sortOption: SortOption? = nil, isNewSearch: Bool = true) async {
        guard !isLoadingPage && canLoadMorePages else { return }
        
        if isNewSearch {
            resetSearch()
        }
        
        self.isLoadingPage = true
        
        let sortQuery = sortOption != nil ? "&sort=\(sortOption!.rawValue)&order=desc" : ""
        let urlString = "https://api.github.com/search/repositories?q=\(query)\(sortQuery)&per_page=30&page=\(currentPage)"
        
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.isLoadingPage = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let searchResults = try JSONDecoder().decode(SearchResults<Repository>.self, from: data)
            
            await MainActor.run {
                if isNewSearch {
                    self.repositories = searchResults.items
                } else {
                    repositories.append(contentsOf: searchResults.items)
                }
                
                isLoadingPage = false
                
                if searchResults.items.count < 30 {
                    canLoadMorePages = false
                } else {
                    currentPage += 1
                }
            }
            
        } catch {
            await MainActor.run  {
                self.isLoadingPage = false
                self.canLoadMorePages = false
            }
        }
    }
}
