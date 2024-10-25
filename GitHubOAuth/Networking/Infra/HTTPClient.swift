//
//  HTTPClient.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

protocol HTTPClient {
    func run(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
}
