//
//  Constants.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation

struct Constants {
    static let githubClientId = ProcessInfo.processInfo.environment["githubClientId"] ?? ""
    static let githubClientSecret = ProcessInfo.processInfo.environment["githubClientSecret"] ?? ""
}
