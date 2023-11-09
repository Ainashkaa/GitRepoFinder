//
//  HistoryView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 07.11.2023.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        NavigationStack {
            List(historyViewModel.history, id: \.id) { user in
                Text(user.login)
            }
            .navigationTitle("History")
            .onAppear {
                historyViewModel.loadHistory()
            }
        }
    }
}

#Preview {
    HistoryView(historyViewModel: HistoryViewModel())
}
