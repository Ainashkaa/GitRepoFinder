//
//  AppViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    private var authManager = AuthManager()
    @Published var isLoggedIn = false
    
    func login() {
        print("hi!")
        AuthManager.shared.authorize{ result in
            print("hi2")
            switch result {
            case .success(let token):
                self.isLoggedIn = true
                print("OAuth token received: \(token)")
            case .failure(let error):
                print("OAuth authorization error: \(error.localizedDescription)")
            }
        }
    }
}
