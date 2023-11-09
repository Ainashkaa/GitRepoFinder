//
//  UserSearchView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel(gitHubService: GitHubService())
    @State private var searchText = ""
    @State private var selectedUser: User?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(value: user) {
                                UserView(user: user)
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
                .onSubmit(of: .search) {
                    Task {
                        await viewModel.searchUsers(query: searchText)
                    }
                }
            }
            .navigationTitle("GitHub Users")
            .navigationDestination(for: User.self) { user in
                UserRepositoryListView(user: user)
            }
        }
    }
    
    private func loadMoreContent() {
        Task {
            await viewModel.searchUsers(query: searchText, isNewSearch: false)
        }
    }
}

#Preview {
    UserListView()
}
