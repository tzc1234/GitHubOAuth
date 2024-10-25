//
//  OAuthConfig.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

struct OAuthConfig {
    let authorizationURL: URL
    let tokenURL: URL
    let clientId: String
    let clientSecret: String
    let redirectURL: URL
    let scopes: [String]
}
