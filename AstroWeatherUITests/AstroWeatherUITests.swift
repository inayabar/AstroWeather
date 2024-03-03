//
//  AstroWeatherUITests.swift
//  AstroWeatherUITests
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import XCTest

final class AstroWeatherUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testFirstLocationIsCurrent_WhenUserAcceptsLocationPermission() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the location permission alert to appear
        let monitor = addUIInterruptionMonitor(withDescription: "Location Permission") { (alert) -> Bool in
            alert.buttons["Allow Once"].tap(); // Don't Allow
            
            return true;
        }
        
        app.swipeUp()
        
        sleep(5)
        
        let locationTitleText = app.staticTexts["San Francisco"]
        
        XCTAssertTrue(locationTitleText.waitForExistence(timeout: 5), "Location did not appear")

        self.removeUIInterruptionMonitor(monitor)
    }
    
    func testFirstLocationIsLondon_WhenUserDeniesLocationPermission() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
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
