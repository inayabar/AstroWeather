//
//  AstroWeatherUITests.swift
//  AstroWeatherUITests
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import XCTest

final class AstroWeatherUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.resetAuthorizationStatus(for: .location)
        app.launch()
    }

    func testFirstLocationIsCurrent_WhenUserAcceptsLocationPermission() throws {
        // Wait for the location permission alert to appear
        let monitor = addUIInterruptionMonitor(withDescription: "Location Permission") { (alert) -> Bool in
            alert.buttons["Allow Once"].tap(); // Don't Allow
            
            return true;
        }
        
        app.tap()
        
        sleep(5)
        
        let locationTitleText = app.staticTexts["My location"]
        
        XCTAssertTrue(locationTitleText.waitForExistence(timeout: 5), "Location did not appear")

        self.removeUIInterruptionMonitor(monitor)
    }
    
    func testFirstLocationIsLondon_WhenUserDeniesLocationPermission() throws {
        // Wait for the location permission alert to appear
        let monitor = addUIInterruptionMonitor(withDescription: "Location Permission") { (alert) -> Bool in
            alert.buttons["Don’t Allow"].tap(); 
            
            return true;
        }
        
        app.swipeUp()
        
        sleep(5)
        
        let locationTitleText = app.staticTexts["London"]
        
        XCTAssertTrue(locationTitleText.waitForExistence(timeout: 5), "Location did not appear")
        
        self.removeUIInterruptionMonitor(monitor)
    }
}
