//
//  Request.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    associatedtype ReturnType: Codable
}

// MARK: - Default Value
extension Request {
    // Default Value
    var method: HTTPMethod { return .GET }
    var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

// MARK: - METHODS
extension Request {
    /// Serializes an HTTP dictionary to a JSON encoded
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params,
              let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        else {
            return nil
        }
        
        return httpBody
    }
    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponent = URLComponents(string: baseURL) else { return nil }
        urlComponent.path = "\(urlComponent.path)\(self.path)"
        guard let finalURL = urlComponent.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = self.method.rawValue
        request.httpBody = self.requestBodyFrom(params: self.body)
        request.allHTTPHeaderFields = self.headers
        if self.method == .POST {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
