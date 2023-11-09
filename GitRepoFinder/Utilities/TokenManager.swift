//
//  TokenManager.swift
//  GitRepoFinder
//
//  Created by Ainash Turbayeva on 09.11.2023.
//

import Foundation
import Security

class TokenManager {

    static let shared = TokenManager()

    private let tokenKey = "GitHubAccessToken"

    func storeToken(token: String) {
        let tokenData = Data(token.utf8)
        let query = [
            kSecValueData: tokenData,
            kSecAttrAccount: tokenKey,
            kSecClass: kSecClassGenericPassword,
        ] as [String: Any]

        SecItemAdd(query as CFDictionary, nil)
    }

    func retrieveToken() -> String? {
        let query = [
            kSecAttrAccount: tokenKey,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr, let dataTypeRef = dataTypeRef as? Data {
            return String(data: dataTypeRef, encoding: .utf8)
        }

        return nil
    }
}
