//
//  GitRepoFinderApp.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import SwiftUI
import OAuthSwift

@main
struct GitRepoFinderApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .onOpenURL(perform: handleOpenURL)
        }
    }
    
    private func handleOpenURL(_ url: URL) {
        OAuthSwift.handle(url: url)
    }
}
