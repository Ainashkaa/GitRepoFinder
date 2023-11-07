//
//  SearchViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation


class SearchViewModel: ObservableObject {
    
    @Published var repositories: [Repository] = []
    @Published var isLoadingPage = false
    
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func resetSearch() {
        repositories = []
        currentPage = 1
        canLoadMorePages = true
        isLoadingPage = false
    }
    
    @MainActor
    func searchRepositories(query: String, sortOption: SortOption? = nil, isNewSearch: Bool = true) async {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        if isNewSearch {
            resetSearch()
        }
        
        self.isLoadingPage = true
        
        let sortQuery = sortOption != nil ? "&sort=\(sortOption!.rawValue)&order=desc" : ""
        var urlString = "https://api.github.com/search/repositories?q=\(query)\(sortQuery)&per_page=30&page=\(currentPage)"
        
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.isLoadingPage = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
            
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
                print(error)
                self.isLoadingPage = false
                self.canLoadMorePages = false
            }
        }
    }
}
