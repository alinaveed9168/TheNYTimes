//
//  NYTimesArticleDetailsUITests.swift
//  NYTimesUITests
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import XCTest

class NYTimesArticleDetailsUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testArticleDetailsUI() {
        // Launch the app
        let app = XCUIApplication()
        app.launchArguments = ["-UITest_DetailView"]
        app.launch()
        
        // Test if the title is shown
        let titleText = app.staticTexts["Article Title"]
        XCTAssertTrue(titleText.exists)
        
        // Test if the published date is shown
        let dateText = app.staticTexts["2025-01-01"]
        XCTAssertTrue(dateText.exists)
        
        // Test if the byline is shown
        let bylineText = app.staticTexts["Byline"] 
        XCTAssertTrue(bylineText.exists)
        
        // Test if the image is loaded (i.e., image exists)
        let articleImage = app.images["detailImage"] // Replace with the actual image identifier
        XCTAssertTrue(articleImage.exists)
        
        // Test if the layout looks correct (check the positioning and sizes of elements)
        // Example: Check if the title is positioned correctly
        let titlePosition = titleText.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let imagePosition = articleImage.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        
    }
}
