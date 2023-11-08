//
//  SearchUsersRequest.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation

struct SearchUsersRequest: GitHubRequest {
    typealias Response = SearchResults<User>

    let query: String
    let sortOption: UsersSort?
    let page: Int
    
    var path: String {
        return "/search/users"
    }

    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/vnd.github.text-match+json"
        ]
    }

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem(name: "q", value: query)]
        if let sort = sortOption {
            items.append(URLQueryItem(name: "sort", value: sort.rawValue))
            items.append(URLQueryItem(name: "order", value: "desc"))
        }
        items.append(URLQueryItem(name: "page", value: String(page)))
        return items
    }
}
