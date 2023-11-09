//
//  LoginViewModel.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    private var authManager = AuthManager()
    @Published var isLoggedIn = false
    @Published var isAuthenticating = false
    
    func login() {
        self.isAuthenticating = true
        AuthManager.shared.authorize{ result in
            DispatchQueue.main.async {
                self.isAuthenticating = false
                switch result {
                case .success(let token):
                    TokenManager.shared.storeToken(token: token)
                    self.isLoggedIn = true
                case .failure(let error):
                    print("OAuth authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
}
