//
//  GetUserRepositoriesRequest.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation

struct GetUserRepositoriesRequest: GitHubRequest {
    typealias Response = SearchResults<Repository>
    
    let login: String
    
    var path: String {
        return "/users/\(login)/repos"
    }

    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]?
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github+json"]
    }
}
