//
//  LoginView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var oauthManager = AuthManager()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                    .resizable()
                    .frame(maxWidth: 256, maxHeight: 256)
                Button("Login") {
                    oauthManager.authorize { result in
                        switch result {
                        case .success(let token):
                            // Handle successful authorization with token
                            print("OAuth token received: \(token)")
                        case .failure(let error):
                            // Handle error
                            print("OAuth authorization error: \(error.localizedDescription)")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 30)
                .foregroundStyle(.white)
                .background(.blue)
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    LoginView()
}
