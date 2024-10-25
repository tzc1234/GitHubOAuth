//
//  InMemoryTokenStore.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

final class InMemoryTokenStore: TokenStore {
    private var token: Token?
    
    func save(_ token: Token) {
        self.token = token
    }
    
    func get() -> Token? {
        token
    }
    
    func remove() {
        token = nil
    }
}
