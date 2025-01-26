//
//  MockURLSession.swift
//  NYTimes
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

struct MockAPI: APIBuilder {
    enum Endpoint {
        case test
    }
    var endpoint: Endpoint
    var urlRequest: URLRequest? {
        switch endpoint {
        case .test:
            return URLRequest(url: URL(string: "https://example.com")!)
        }
    }
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: URLError?
    
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        let response = self.response ?? URLResponse()
        let data = self.data ?? Data()
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
