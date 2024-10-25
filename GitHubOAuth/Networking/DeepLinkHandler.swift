//
//  DeepLinkHandler.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

struct DeepLink {
    let baseURL: URL
    let action: (URL) -> Void
    
    func handled(_ deepLinkURL: URL) -> Bool {
        guard canHandle(deepLinkURL: deepLinkURL) else { return false }
        
        action(deepLinkURL)
        return true
    }
    
    private func canHandle(deepLinkURL: URL) -> Bool {
        deepLinkURL.absoluteString.hasPrefix(baseURL.absoluteString)
    }
}

// MARK: - DeepLinkHandler

final class DeepLinkHandler {
    private var deepLinks = [DeepLink]()
    
    func add(_ deepLink: DeepLink) {
        deepLinks.append(deepLink)
    }
    
    func handleDeepLinkIfPossible(deepLinkURL: URL) {
        _ = deepLinks.first { $0.handled(deepLinkURL) }
    }
}
