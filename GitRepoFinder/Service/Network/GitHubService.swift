//
//  GitHubService.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation

class GitHubService {
    func searchRepositories(request: SearchRepositoriesRequest) async throws -> SearchResults<Repository> {
        let urlRequest = try request.makeRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(SearchResults<Repository>.self, from: data)
    }
    
    func searchUsers(request: SearchUsersRequest) async throws -> SearchResults<User> {
        let urlRequest = try request.makeRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(SearchResults<User>.self, from: data)
    }
}
