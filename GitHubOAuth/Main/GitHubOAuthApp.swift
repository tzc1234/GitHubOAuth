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
    private let viewModel: LoginViewModel
    
    init() {
        self.viewModel = LoginViewModel(loader: dependencies.loader)
        self.dependencies.deepLinkHandler.add(DeepLink(baseURL: dependencies.redirectURL, action: { [weak viewModel] url in
            guard let result = GitHubOAuthCodeStateExtractor.extract(from: url) else { return }
            
            viewModel?.exchangeForToken(code: result.code, state: result.state)
        }))
    }
    
    var body: some Scene {
        WindowGroup {
            LoginViewContainer(viewModel: viewModel)
                .onOpenURL { url in
                    dependencies.deepLinkHandler.handleDeepLinkIfPossible(deepLinkURL: url)
                }
        }
    }
}
