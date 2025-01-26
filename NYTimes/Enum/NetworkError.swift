//
//  NetworkError.swift
//  NYTimes
//
//  Created by ALI Naveed on 25/01/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case decodeError
    case unknownError
    case errorCode(String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Unexpected status code")
        case .decodeError:
            return NSLocalizedString("Decode error", comment: "Unexpected JSON")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        }
    }
}
