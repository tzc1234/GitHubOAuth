//
//  TokenResponseMapper.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

enum TokenResponseMapper {
    private struct TokenResponse: Decodable {
        let accessToken: String
        let scope: String
        let tokenType: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case scope
            case tokenType = "token_type"
        }
    }
    
    static func map(_ data: Data, response: HTTPURLResponse) throws -> Token {
        guard (200...299).contains(response.statusCode),
                let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
            throw GitHubOAuthTokenLoader.Error.invalidData
        }
        
        return Token(assessToken: tokenResponse.accessToken)
    }
}
