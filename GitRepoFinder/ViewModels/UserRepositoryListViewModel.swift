//
//  UserRepositoryListViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation

class UserRepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    
    private var gitHubService: GitHubService
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
    }
    
    @MainActor
    func loadRepositories(for user: User) async {
        let request = GetUserRepositoriesRequest(login: user.login)
        do {
            let results = try await gitHubService.getUserRepositories(request: request)
            repositories = results
        } catch {
            print("error")
        }
    }
    
    func markRepositoryAsViewed(withId id: Int) {
        if let index = repositories.firstIndex(where: { $0.id == id }) {
            repositories[index].isViewed = true
        }
    }
}
