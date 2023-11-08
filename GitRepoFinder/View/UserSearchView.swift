//
//  UserSearchView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import SwiftUI

struct UserSearchView: View {
    
    @StateObject var viewModel = UserSearch()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.users) { user in
                            UserRow(user: user, markAsViewed: {
                                viewModel.markUserAsViewed(withId: user.id)
                            })
                            .onAppear {
                                if user == viewModel.users.last {
                                    loadMoreContent()
                                }
                            }
                        }
                        if viewModel.isLoading {
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
        }
    }
    
    private func loadMoreContent() {
        Task {
            await viewModel.searchUsers(query: searchText, isNewSearch: false)
        }
    }
}

struct UserRow: View {
    let user: User
    var markAsViewed: () -> Void
    
    
    var body: some View {
        VStack {
            HStack {
                if let name = user.name {
                    Text(name)
                }
                Text(user.login)
            }
            if let bio = user.bio {
                Text(bio)
            }
            HStack {
                if let location = user.location {
                    Text(location)
                }
                if let followers = user.followers {
                    Text("\(followers)")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    UserSearchView()
}
