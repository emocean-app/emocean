//
//  NetworkRequestError.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation

enum NetworkRequestError: Error, LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

extension NetworkRequestError {
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Network Request Error: Invalid Request"
        case .badRequest:
            return "Network Request Error: Bad Request"
        case .unauthorized:
            return "Network Request Error: Unauthorized"
        case .forbidden:
            return "Network Request Error: Forbidden"
        case .notFound:
            return "Network Request Error: Not Found"
        case .error4xx(let code):
            return "Network Request Error: \(code)"
        case .serverError:
            return "Network Request Error: Server Error"
        case .error5xx(let code):
            return "Network Request Error: \(code)"
        case .decodingError:
            return "Network Request Error: Decoding Error"
        case .urlSessionFailed(let err):
            return "Network Request Error: \(err)"
        case .unknownError:
            return "Network Request Error: Unknown Error"
        }
    }
}

