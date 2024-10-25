//
//  OAuthTokenLoader.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

struct AuthParamsBuilder {
    let clientId: String
    let redirectURL: String
    let state: String
    let scope: String
    
    var params: [String: String] {
        [
            "client_id": clientId,
            "redirect_uri": redirectURL,
            "state": state,
            "scope": scope
        ]
    }
}

struct TokenParamsBuilder {
    let clientId: String
    let clientSecret: String
    let code: String
    let redirectURL: String
    let state: String
    
    var params: [String: String] {
        [
            "client_id": clientId,
            "client_secret": clientSecret,
            "redirect_uri": redirectURL,
            "state": state,
            "code": code
        ]
    }
}

final class OAuthTokenLoader {
    private let client: HTTPClient
    private let config: OAuthConfig
    
    init(client: HTTPClient, config: OAuthConfig) {
        self.client = client
        self.config = config
    }
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    func authPageURL(state: String = UUID().uuidString) -> URL? {
        let authParams = AuthParamsBuilder(
            clientId: config.clientId,
            redirectURL: config.redirectURL.absoluteString,
            state: state,
            scope: config.scopes.joined(separator: " ")
        )
        let endpoint = Endpoint(baseURL: config.authorizationURL, params: authParams.params)
        return endpoint.request.url
    }
    
    func exchangeForToken(code: String, state: String) async throws -> Token {
        let tokenParams = TokenParamsBuilder(
            clientId: config.clientId,
            clientSecret: config.clientSecret,
            code: code,
            redirectURL: config.redirectURL.absoluteString,
            state: state
        )
        let endpoint = Endpoint(
            baseURL: config.tokenURL,
            method: .post,
            params: tokenParams.params,
            headers: ["Accept": "application/json"]
        )
        
        let (data, response) = try await client.run(request: endpoint.request)
        return try TokenResponseMapper.map(data, response: response)
    }
}
