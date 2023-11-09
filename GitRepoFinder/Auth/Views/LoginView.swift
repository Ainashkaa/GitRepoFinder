//
//  LoginView.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                    .resizable()
                    .frame(maxWidth: 256, maxHeight: 256)
                Button("Login") {
                    loginViewModel.login()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(configuration.isPressed ? Color.blue.opacity(0.8) : .blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
