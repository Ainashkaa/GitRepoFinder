//
//  HistoryView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 07.11.2023.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var historyManager = HistoryManager()
    
    var body: some View {
        List(historyManager.getHistory(), id: \.id) { user in
            HStack {
                AsyncImage(url: URL(string: user.avatarUrl))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(user.login)
                        .fontWeight(.bold)
                    Text("Followers: \(user.followers)")
                }
            }
        }
        .navigationBarTitle("Viewed Users", displayMode: .inline)
    }
}

#Preview {
    HistoryView()
}
