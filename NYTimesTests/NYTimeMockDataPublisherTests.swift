//
//  NYTimeMockDataPublisher.swift
//  NYTimesTests
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import Combine

import XCTest
@testable import NYTimes

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockSession: MockURLSession!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkManager = NetworkManager()
        cancellables = []
    }
    
    override func tearDown() {
        networkManager = nil
        mockSession = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testMapErrorWithDecodingError() {
        // Given
        let invalidJSON = "{ \"invalid\": \"json\" }".data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "https://testMapErrorWithDecodingError.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        mockSession.data = invalidJSON
        mockSession.response = response
        
        let endpoint = MockAPI(endpoint: .test)
        
        let expectation = XCTestExpectation(description: "Decoding error is mapped correctly")
        
        // When
        networkManager.getData(endpoint: endpoint, type: Article.self)
            .sink(receiveCompletion: { completion in
                // Then
                if case .failure(let error) = completion {
                    if case .errorCode(let description) = error {
                        XCTAssertEqual(description, "type Mismatch")
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected a decoding error, but got \(error)")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Expected decoding to fail, but it succeeded")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
