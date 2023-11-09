//
//  RepositoryModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation

struct Repository: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var fullName: String
    var description: String?
    var updatedDate: String
    var starsCount: Int?
    var forksCount: Int?
    var isViewed: Bool = false
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case fullName = "full_name"
        case updatedDate = "updated_at"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description available."
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
        self.starsCount = try container.decodeIfPresent(Int.self, forKey: .starsCount) ?? 0
        self.forksCount = try container.decodeIfPresent(Int.self, forKey: .forksCount) ?? 0
        self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
    }
    
    init(id: Int, name: String, fullName: String, description: String, starsCount: Int, forksCount: Int, updatedDate: String, isViewed: Bool, htmlUrl: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.description = description
        self.starsCount = starsCount
        self.forksCount = forksCount
        self.updatedDate = updatedDate
        self.isViewed = isViewed
        self.htmlUrl = htmlUrl
    }
    
}


extension Repository {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var formattedUpdateDate: String {
        Repository.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = Repository.dateFormatter.date(from: updatedDate) else {
            return "Unknown date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        
        if let daysAgo = calendar.dateComponents([.day], from: date, to: now).day, daysAgo < 7 {
            switch daysAgo {
            case 0:
                return "Updated today"
            case 1:
                return "Updated yesterday"
            default:
                return "Updated \(daysAgo) days ago"
            }
        } else {
            let updatedYear = calendar.component(.year, from: date)
            Repository.dateFormatter.dateFormat = updatedYear == currentYear ? "MMM d" : "MMM d, yyyy"
            return "Updated on \(Repository.dateFormatter.string(from: date))"
        }
    }
}
