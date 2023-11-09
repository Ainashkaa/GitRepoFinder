//
//  User.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import Foundation

struct User: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let login: String
    let reposUrl: String
    
    var isViewed: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case reposUrl = "repos_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.reposUrl = try container.decode(String.self, forKey: .reposUrl)
    }
    
    init(id: Int, login: String, repoUrl: String, isViewed: Bool) {
        self.id = id
        self.login = login
        self.reposUrl = repoUrl
    }
}
