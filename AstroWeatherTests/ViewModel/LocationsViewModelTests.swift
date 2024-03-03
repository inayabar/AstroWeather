//
//  LocationsViewModelTests.swift
//  AstroWeatherTests
//
//  Created by Iñaki Yabar Bilbao on 02/03/2024.
//

import XCTest
import CoreLocation
@testable import AstroWeather

final class LocationsViewModelTests: XCTestCase {
    func testInit_whenLocationIsNotEnabled_shouldLoadDefaultLocations() throws {
        // Given
        let mockLocationManager = MockLocationManager()
        mockLocationManager.coordinate = nil
        
        // When
        let viewModel = LocationsViewModel(locationManager: mockLocationManager)
        
        // Then
        XCTAssertEqual(5, viewModel.locations.count)
        XCTAssertEqual(Location.list, viewModel.locations)
    }
    
    func testInit_whenLocationIsEnabled_shouldAppendCurrentLocation() throws {
        // Given
        let mockLocationManager = MockLocationManager()
        mockLocationManager.coordinate = CLLocationCoordinate2D(latitude: -10.000, longitude: 20.000)
        
        // When
        let viewModel = LocationsViewModel(locationManager: mockLocationManager)
        
        // Then
        XCTAssertEqual(6, viewModel.locations.count)
        XCTAssertTrue(viewModel.locations.first!.isCurrent)
    }
    
    func testLocationManagerDelegate_whenLocationHasChanged_shouldModifyCurrentLocation() throws {
        // Given
        let mockLocationManager = MockLocationManager()
        mockLocationManager.coordinate = CLLocationCoordinate2D(latitude: -10.000, longitude: 20.000)
        let viewModel = LocationsViewModel(locationManager: mockLocationManager)
        
        // When
        mockLocationManager.coordinate = CLLocationCoordinate2D(latitude: -15.000, longitude: 25.000)
        mockLocationManager.updateLocation()
        
        // Then
        XCTAssertEqual(6, viewModel.locations.count)
        let current = viewModel.locations.first!
        XCTAssertTrue(current.isCurrent)
        XCTAssertEqual(-15.000, current.latitude)
        XCTAssertEqual(25.000, current.longitude)
    }
}
