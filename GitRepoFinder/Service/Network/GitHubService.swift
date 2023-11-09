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
    
    func getUserRepositories(request: GetUserRepositoriesRequest) async throws -> [Repository] {
        let urlRequest = try request.makeRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode([Repository].self, from: data)
        default:
            if let errorMessage = try? JSONDecoder().decode(GitHubAPIError.self, from: data) {
                print("GitHub API Error: \(errorMessage.message)")
                throw errorMessage
            } else {
                let errorString = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("HTTP Error \(httpResponse.statusCode): \(errorString)")
                throw HTTPError(statusCode: httpResponse.statusCode, response: httpResponse)
            }
        }
    }
}

struct HTTPError: Error {
    let statusCode: Int
    let response: HTTPURLResponse
}

struct GitHubAPIError: Codable, Error {
    let message: String
}
