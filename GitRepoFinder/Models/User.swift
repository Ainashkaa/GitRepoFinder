//
//  User.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let name: String?
    let login: String
//    let avatarUrl: String
    let followers: Int?
//    let htmlUrl: String
    let bio: String?
    let location: String?
//    var isViewed: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, login, name, bio, location, followers
//        case avatarUrl = "avatar_url"
//        case htmlUrl = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "" 
        self.login = try container.decode(String.self, forKey: .login)
//        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
//        self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
    }
}
