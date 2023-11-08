//
//  SearchRepositoriesRequest.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation

struct SearchRepositoriesRequest: GitHubRequest {
    typealias Response = SearchResults<Repository>

    let query: String
    let sortOption: SortOption?
    let page: Int

    var path: String {
        return "/search/repositories"
    }

    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem(name: "q", value: query)]
        if let sort = sortOption, sort != .none {
            items.append(URLQueryItem(name: "sort", value: sort.rawValue))
        }
        items.append(URLQueryItem(name: "page", value: String(page)))
        return items
    }
}
