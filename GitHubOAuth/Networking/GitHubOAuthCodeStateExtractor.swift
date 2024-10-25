//
//  GitHubOAuthCodeStateExtractor.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

enum GitHubOAuthCodeStateExtractor {
    static func extract(from url: URL) -> (code: String, state: String)? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        let code = components.queryItems?.first(where: { $0.name == "code" })?.value
        let state = components.queryItems?.first(where: { $0.name == "state" })?.value
        
        guard let code, let state else { return nil }
        
        return (code, state)
    }
}
