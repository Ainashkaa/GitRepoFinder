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
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case fullName = "full_name"
        case updatedDate = "updated_at"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
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
    }
    
}

struct SearchResults: Codable {
    var items: [Repository]
}

extension Repository {
    var formattedUpdateDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = dateFormatter.date(from: updatedDate) else {
            return "Unknown date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        
        if let daysAgo = calendar.dateComponents([.day], from: date, to: now).day, daysAgo < 7 {
            if daysAgo == 0 {
                return "Updated today"
            } else if daysAgo == 1 {
                return "Updated yesterday"
            } else {
                return "Updated \(daysAgo) days ago"
            }
        } else {
            let updatedYear = calendar.component(.year, from: date)
            dateFormatter.dateFormat = updatedYear == currentYear ? "MMM d" : "MMM d, yyyy"
            return "Updated on \(dateFormatter.string(from: date))"
        }
    }
}
