//
//  Endpoint.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import Foundation

struct Endpoint {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    let baseURL: URL
    let method: Method
    let params: [String: String]?
    let headers: [String: String]?
    
    init(baseURL: URL, method: Method = .get, params: [String: String]? = nil, headers: [String: String]? = nil) {
        self.baseURL = baseURL
        self.method = method
        self.params = params
        self.headers = headers
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        setCommonHeaders(in: &request)
        return request
    }
    
    private var url: URL {
        switch method {
        case .get:
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
            components.queryItems = queryItems
            return components.url!
        case .post:
            return baseURL
        }
    }
    
    private var body: Data? {
        switch method {
        case .get:
            return nil
        case .post:
            guard let params else { return nil }
            return try? JSONSerialization.data(withJSONObject: params)
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        params?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    }
    
    private func setCommonHeaders(in request: inout URLRequest) {
        commonHeaders.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    private var commonHeaders: [String: String] {
        ["Content-Type": "application/json"]
    }
}
