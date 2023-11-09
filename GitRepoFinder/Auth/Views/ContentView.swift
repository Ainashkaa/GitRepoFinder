//
//  ContentView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 06.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Group {
            if loginViewModel.isAuthenticating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
            else if loginViewModel.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
