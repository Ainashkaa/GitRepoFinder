//
//  UserRepositoryListView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import SwiftUI

struct UserRepositoryListView: View {
    var user: User
    @StateObject var viewModel: UserRepositoryListViewModel = UserRepositoryListViewModel(gitHubService: GitHubService())
    
    var body: some View {
        
        List(viewModel.repositories) { repository in
            RepositoryView(repository: repository, markAsViewed: {
                viewModel.markRepositoryAsViewed(withId: repository.id)
            })
        }.onAppear() {
            Task {
                await viewModel.loadRepositories(for: user)
            }
        }
    }
}

#Preview {
    UserRepositoryListView(user: .init(id: 370576, login: "ain", repoUrl: "https://api.github.com/users/ain/repos", isViewed: false))
}
