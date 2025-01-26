//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by ALI Naveed on 23/01/2025.
//

import XCTest
import Combine
@testable import NYTimes

enum ResultE<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}

class MockNetworkManager: NetworkManagerProtocol {
    var result: ResultE<Any, NetworkError>?

    func getData<T: Decodable>(endpoint: APIBuilder, type: T.Type) -> AnyPublisher<T, NetworkError> {
        switch result {
        case .success(let data):
            guard let typedData = data as? T else {
                return Fail(error: NetworkError.errorCode("Type mismatch")).eraseToAnyPublisher()
            }
            return Just(typedData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
            
        case .none:
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
    }
}

final class ArticleViewModelTests: XCTestCase {
    var viewModel: ArticleViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = ArticleViewModel(service: mockNetworkManager)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetArticles_SuccessfulResponse() {
        // Given
        let mockResults = [Result(publishedDate: "24-05-2025"), Result(publishedDate: "24-05-2026")]
        let mockArticle = Article(status: "", copyright: "", numResults: 1, results: mockResults)
        mockNetworkManager.result = .success(mockArticle)
        
        let expectation = XCTestExpectation(description: "Fetch articles successfully")
        
        // When
        viewModel.$resultList
            .dropFirst()
            .sink { resultList in
                // Then
                XCTAssertEqual(resultList.count, 2)
                XCTAssertEqual(resultList[0].publishedDate, "24-05-2025")
                XCTAssertEqual(resultList[1].publishedDate, "24-05-2026")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getArticles()
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetArticles_ErrorResponse() {
        // Given
        mockNetworkManager.result = .failure(NetworkError.responseError)
        
        let expectation = XCTestExpectation(description: "Handle error response")
        
        // When
        viewModel.getArticles()
        
        // Observe error property
        viewModel.$state
            .dropFirst() // Ignore initial nil value
            .sink { error in
                // Then
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetArticles_InvalidURL() {
        // Given
        mockNetworkManager.result = nil // Result is irrelevant for invalid URL
        let invalidEndpoint = ArticleAPI(endpoint: .invalidEndpoint)

        let expectation = XCTestExpectation(description: "Handle invalid URL error")

        // When
        let publisher = NetworkManager().getData(endpoint: invalidEndpoint, type: Article.self)
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error.errorDescription, NetworkError.invalidURL.errorDescription)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 4)
    }
    
}
