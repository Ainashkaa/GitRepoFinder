//
//  SearchView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var showingSortMenu = false
    @State private var selectedSortOption: SortOption = .none
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Picker("Sort by", selection: $selectedSortOption) {
                        Text("Sort").tag(SortOption.none)
                        ForEach(SortOption.allCases.filter { $0 != .none }, id: \.self) { option in
                            Text(option.displayName).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding()
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.repositories) { repository in
                            RepositoryRow(repository: repository)
                                .onAppear {
                                    if repository == viewModel.repositories.last {
                                        loadMoreContent()
                                        print("\(repository.id)")
                                    }
                                }
                        }
                        if viewModel.isLoadingPage {
                            ProgressView()
                        }
                    }
                    .padding()
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) {
                    viewModel.resetSearch()
                }
                .onChange(of: selectedSortOption) {
                    Task {
                        await viewModel.searchRepositories(query: searchText, sortOption: selectedSortOption)
                    }
                }
                .onSubmit(of: .search) {
                    Task {
                        await viewModel.searchRepositories(query: searchText, sortOption: selectedSortOption)
                    }
                }
            }
            .navigationTitle("GitHub Repositories")
        }
    }
    
    private func loadMoreContent() {
        Task {
            await viewModel.searchRepositories(query: searchText, isNewSearch: false)
        }
    }
}

#Preview {
    SearchView()
}
