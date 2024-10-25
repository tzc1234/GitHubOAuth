//
//  TokenStore.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

protocol TokenStore {
    func save(_ token: Token)
    func get() -> Token?
    func remove()
}
