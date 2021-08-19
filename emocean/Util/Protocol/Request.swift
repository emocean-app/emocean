//
//  Request.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation

// HTTP Method Enum
public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// Request Protocol
public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
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
        else { return nil }
        return httpBody
    }
    /// Convert Dictionary of query parameter to array of URLQueryItem
    /// - Parameter queryParams: Dictionary of query params
    /// - Returns: An array of URLQueryItem
    private func getQueryItems(queryParams: [String: String]?) -> [URLQueryItem] {
        // Unwrap
        guard let params = queryParams else { return [] }
        // Array of URLQueryItem
        var arr: [URLQueryItem] = []
        // Looping trough params and append to array
        for (key, value) in params {
            arr.append(URLQueryItem(name: key, value: value))
        }
        // Return array of URLQueryItem
        return arr
    }
    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        // SETUP URL
        guard var urlComponent = URLComponents(string: baseURL) else { return nil }
        urlComponent.path = "\(urlComponent.path)\(self.path)"
        urlComponent.queryItems = getQueryItems(queryParams: self.queryParams)
        guard let finalURL = urlComponent.url else { return nil }
        // SETUP URLRequest
        var request = URLRequest(url: finalURL)
        request.httpMethod = self.method.rawValue
        request.httpBody = self.requestBodyFrom(params: self.body)
        request.allHTTPHeaderFields = self.headers
        // RETURN Request
        return request
    }
}
