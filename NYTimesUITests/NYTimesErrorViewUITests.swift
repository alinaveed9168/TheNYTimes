//
//  NYTimesErrorViewUITests.swift
//  NYTimesUITests
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import XCTest

final class ErrorViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Set up the app and launch it
        app = XCUIApplication()
        app.launchArguments = ["-UITest_ErrorView"]
        app.launch()
        
        // Continue testing even after failure
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testErrorViewUI() throws {
        // Verify the error icon is present
        let errorIcon = app.images["ErrorIcon"]
        XCTAssertTrue(errorIcon.exists, "Error icon should be visible")
        
        // Verify the "Ooops..." text is present
        let titleText = app.staticTexts["check error..."]
        XCTAssertTrue(titleText.exists, "Title text should be visible")
        
        // Verify the error description text is present
        let descriptionText = app.staticTexts["Decode error"]
        XCTAssertTrue(descriptionText.exists, "Error description should be visible")
        
        // Verify the "Retry" button is present
        let retryButton = app.buttons["Retry Please"]
        XCTAssertTrue(retryButton.exists, "Retry button should be visible")
        
        // Simulate tapping the Retry button
        retryButton.tap()
    }
}
