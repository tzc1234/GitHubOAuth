//
//  StoreOAuthTokenLoaderDecorator.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

final class StoreOAuthTokenLoaderDecorator: OAuthTokenLoader {
    private let loader: OAuthTokenLoader
    private let store: (Token) -> Void
    
    init (loader: OAuthTokenLoader, store: @escaping (Token) -> Void) {
        self.loader = loader
        self.store = store
    }
    
    func authPageURL() -> URL? {
        loader.authPageURL()
    }
    
    func exchangeForToken(code: String, state: String) async throws -> Token {
        let token = try await loader.exchangeForToken(code: code, state: state)
        store(token)
        return token
    }
}
