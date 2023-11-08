//
//  MainTabView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RepositoryListView()
                .tabItem {
                    Label("Repositories", systemImage: "list.bullet.rectangle")
                }
            UserSearchView()
                .tabItem {
                    Label("Users", systemImage: "person.3.fill")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
