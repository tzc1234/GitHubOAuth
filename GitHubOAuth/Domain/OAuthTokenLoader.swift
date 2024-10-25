//
//  OAuthTokenLoader.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

protocol OAuthTokenLoader {
    func authPageURL() -> URL?
    func exchangeForToken(code: String, state: String) async throws -> Token
}
