//
//  NYTimeEndPoints.swift
//  NYTimes
//
//  Created by ALI Naveed on 25/01/2025.
//

import Foundation

struct AppConstants {
    static let apiBaseURL = "https://api.nytimes.com/"
    static let apiKey = "api-key=SZgjwdVxOSxn5MnlQh6vAZkAv7Q8wFqf"
}

protocol APIBuilder {
    var urlRequest: URLRequest? { get }
}

// Define Endpoint structure
struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

// Define ArticleAPI conforming to the protocol
struct ArticleAPI: APIBuilder {
   
    // Define enum for different API endpoints
    enum Endpoint {
        case topArticle
        case invalidEndpoint
        
        // Define a computed property to get the associated URL for each endpoint
        var urlString: String {
            switch self {
            case .topArticle:
                return "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?" + AppConstants.apiKey
            case .invalidEndpoint:
                return ""
            }
        }
    }
    
    // This is required by the `APIBuilder` protocol
    var endpoint: Endpoint
    
    // Computed property for the URLRequest, based on the selected endpoint
    var urlRequest: URLRequest? {
        guard let url = URL(string: endpoint.urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
