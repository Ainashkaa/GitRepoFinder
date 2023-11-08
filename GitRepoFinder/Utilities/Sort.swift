//
//  Sort.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 06.11.2023.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case none, stars, forks, updated
    var id: SortOption { self }
    
    var displayName: String {
        switch self {
        case .stars:
            return "stars"
        case .forks:
            return "forks"
        case .updated:
            return "updated"
        case .none:
            return "None"
        }
    }
}
