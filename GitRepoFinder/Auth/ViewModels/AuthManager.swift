//
//  AuthManager.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 05.11.2023.
//

import Foundation
import Combine
import OAuthSwift

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    private var oauthswift: OAuth2Swift?
    
    
    private let clientId       = Constants.githubClientId
    private let clientSecret   = Constants.githubClientSecret
    private let authorizeUrl   = "https://github.com/login/oauth/authorize"
    private let accessTokenUrl = "https://github.com/login/oauth/access_token"
    private let responseType   = "code"
    
    private let callbackUrl = URL(string: "com.ai.myapp://callback")!
    
    init() {
        self.oauthswift = OAuth2Swift(
            consumerKey: clientId,
            consumerSecret: clientSecret,
            authorizeUrl: authorizeUrl,
            accessTokenUrl: accessTokenUrl,
            responseType: responseType
        )
    }
    func authorize(completion: @escaping (Result<String, OAuthSwiftError>) -> Void) {
        guard let oauthswift = self.oauthswift else { return }
        oauthswift.authorize(withCallbackURL: callbackUrl, scope: "read:user", state: generateState(withLength: 7)) {
            result in
            switch result {
            case .success(let (credential, _, _)):
                // Save the credential oauth token as needed.
                DispatchQueue.main.async{
                    completion(.success(credential.oauthToken))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func generateState(withLength len: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<len).map{ _ in letters.randomElement()! })
    }
}
