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
            return "Stars"
        case .forks:
            return "Forks"
        case .updated:
            return "Recently Updated"
        case .none:
            return "None"
        }
    }
}
