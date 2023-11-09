//
//  SearchResults.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import Foundation

struct SearchResults<T: Codable>: Codable {
    var items: [T]
}
