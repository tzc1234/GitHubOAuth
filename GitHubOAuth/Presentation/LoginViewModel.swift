//
//  LoginViewModel.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published private(set) var token: Token?
    @Published var errorMessage: String?
    
    private let loader: OAuthTokenLoader
    
    init(loader: OAuthTokenLoader) {
        self.loader = loader
    }
    
    func authPageURL() -> URL? {
        loader.authPageURL()
    }
    
    func exchangeForToken(code: String, state: String) {
        Task { @MainActor in
            do {
                let token = try await loader.exchangeForToken(code: code, state: state)
                self.token = token
                errorMessage = nil
                print("get token success: \(token.assessToken)")
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
}
