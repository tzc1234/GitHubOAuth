//
//  LoginViewModel.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published private(set) var token: Token?
    @Published private(set) var message: String?
    @Published var showError = false
    
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
                token = try await loader.exchangeForToken(code: code, state: state)
                message = "Success"
                print("get token success: \(token?.assessToken ?? "")")
            } catch let error {
                message = error.localizedDescription
                print("get token failure: \(message ?? "")")
            }
            
            showError = message != nil
        }
    }
}
