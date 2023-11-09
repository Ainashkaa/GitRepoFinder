//
//  HistoryManager.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 07.11.2023.
//

import Foundation

class HistoryManager: ObservableObject {
    
    private let defaults = UserDefaults.standard
    private let historyKey = "viewedUserHistory"
    private let maxHistoryCount = 20
    
    func addToHistory(user: User) {
        var history = getHistory()
        history.insert(user, at: 0)
        if history.count > maxHistoryCount {
            history.removeLast()
        }
        saveHistory(history)
    }
    
    func getHistory() -> [User] {
        guard let data = defaults.data(forKey: historyKey),
              let history = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return history
    }
    
    private func saveHistory(_ history: [User]) {
        if let data = try? JSONEncoder().encode(history) {
            defaults.set(data, forKey: historyKey)
        }
    }
}
