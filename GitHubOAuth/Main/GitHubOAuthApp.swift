//
//  GitHubOAuthApp.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import SwiftUI

@main
struct GitHubOAuthApp: App {
    private let dependencies = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            LoginViewContainer(viewModel: LoginViewModel(loader: dependencies.loader))
        }
    }
}

final class DependencyContainer {
    private let redirectURL = URL(string: "com.tszlung.githuboauth://authentication")!
    private lazy var config = OAuthConfig(
        authorizationURL: URL(string: "https://github.com/login/oauth/authorize")!,
        tokenURL: URL(string: "https://github.com/login/oauth/access_token")!,
        clientId: "clientId",
        clientSecret: "clientSecret",
        redirectURL: redirectURL,
        scopes: ["repo", "user"]
    )
    
    private let client = URLSessionHTTPClient(session: .shared)
    private(set) lazy var loader = GitHubOAuthTokenLoader(client: client, config: config)
}
