//
//  URLSessionHTTPClient.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    enum Error: Swift.Error {
        case invalidResponse
    }
    
    func run(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.invalidResponse
        }
        
        return (data, response)
    }
}
