//
//  NYTimeErrorCodeTests.swift
//  NYTimesTests
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import XCTest
@testable import NYTimes

final class NetworkErrorTests: XCTestCase {
    func testInvalidURLErrorDescription() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(error.localizedDescription, "Invalid URL", "Invalid URL description does not match.")
    }
    
    func testResponseErrorDescription() {
        let error = NetworkError.responseError
        XCTAssertEqual(error.localizedDescription, "Unexpected status code", "Response error description does not match.")
    }
    
    func testDecodeErrorDescription() {
        let error = NetworkError.decodeError
        XCTAssertEqual(error.localizedDescription, "Decode error", "Decode error description does not match.")
    }
    
    func testUnknownErrorDescription() {
        let error = NetworkError.unknownError
        XCTAssertEqual(error.localizedDescription, "Unknown error", "Unknown error description does not match.")
    }
    
    func testErrorCodeDescription() {
        let error = NetworkError.errorCode("404")
        XCTAssertEqual(error.localizedDescription, "404 - Something went wrong", "Error code description does not match.")
    }
}
