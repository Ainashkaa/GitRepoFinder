//
//  UserView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                Text(user.login)
            }
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

