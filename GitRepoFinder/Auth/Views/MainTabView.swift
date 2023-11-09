//
//  MainTabView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 08.11.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var historyViewModel = HistoryViewModel()
    
    var body: some View {
        TabView {
            RepositoryListView()
                .tabItem {
                    Label("Repositories", systemImage: "list.bullet.rectangle")
                }
            UserListView()
                .tabItem {
                    Label("Users", systemImage: "person.3.fill")
                }
            
            HistoryView(historyViewModel: historyViewModel)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
