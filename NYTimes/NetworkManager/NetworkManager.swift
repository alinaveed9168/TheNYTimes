//
//  NetworkManager.swift
//  NYTimes
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getData<T:Decodable>(endpoint: APIBuilder,type:T.Type) -> AnyPublisher<T, NetworkError>
}

struct NetworkManager: NetworkManagerProtocol {

    func getData<T: Decodable>(endpoint: APIBuilder, type: T.Type) -> AnyPublisher<T, NetworkError> {
        
        guard let urlRequest = endpoint.urlRequest, urlRequest.url != nil else {
                return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        // Perform the network request and build the publisher chain
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    throw NetworkError.responseError
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.errorCode(decodingError.errorDescription ?? "type Mismatch")
                } else {
                    return NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}
