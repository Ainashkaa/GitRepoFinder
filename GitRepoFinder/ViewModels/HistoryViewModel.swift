//
//  HistoryViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 07.11.2023.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published var history: [User] = []
    
    private let defaults = UserDefaults.standard
    private let historyKey = "viewedUserHistory"
    private let maxHistoryCount = 20
    
    init() {
        loadHistory()
    }
    
    func userViewed(_ user: User) {
        addToHistory(user: user)
    }
    
    func addToHistory(user: User) {
        var newHistory = getHistory()
        if let index = newHistory.firstIndex(where: { $0.id == user.id }) {
            newHistory.remove(at: index)
        }
        newHistory.insert(user, at: 0)
        if newHistory.count > maxHistoryCount {
            newHistory.removeLast()
        }
        history = newHistory 
        saveHistory(newHistory)
    }
    
    func getHistory() -> [User] {
        guard let data = defaults.data(forKey: historyKey),
              let history = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return history
    }
    
     func saveHistory(_ history: [User]) {
        if let data = try? JSONEncoder().encode(history) {
            defaults.set(data, forKey: historyKey)
        }
    }
    
     func loadHistory() {
        history = getHistory()
    }
}
