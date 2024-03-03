//
//  LocationWeatherViewModelTests.swift
//  AstroWeatherTests
//
//  Created by Iñaki Yabar Bilbao on 02/03/2024.
//

import XCTest
@testable import AstroWeather

final class LocationWeatherViewModelTests: XCTestCase {
    @MainActor
    func testLoadLocationWeather_whenServiceFails_shouldShowError() async throws {
        // Given
        let viewModel = LocationWeatherViewModel(location: MockLocation.current, weatherFetcher: FailingMockWeatherFetcher())
        
        // When
        await viewModel.loadLocationWeather()
        
        // Then
        XCTAssertNil(viewModel.weather)
        XCTAssertTrue(viewModel.isShowingError)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testLoadLocationWeather_whenServiceSucceeds_shouldShowWeatherData() async throws {
        // Given
        let viewModel = LocationWeatherViewModel(location: MockLocation.london, weatherFetcher: MockWeatherFetcher())

        // When
        await viewModel.loadLocationWeather()

        // Then
        XCTAssertNotNil(viewModel.weather)
        XCTAssertFalse(viewModel.isShowingError)
        
        XCTAssertEqual("Vicente López", viewModel.locationName)
        XCTAssertFalse(viewModel.isCurrentLocation)
        XCTAssertEqual("Completamente despejada", viewModel.visibilityDescription)
        XCTAssertNotNil(viewModel.sunrise)
        XCTAssertEqual("06:41 AM", viewModel.sunrise!)
        XCTAssertNotNil(viewModel.sunset)
        XCTAssertEqual("19:32 PM", viewModel.sunset!)
    }
    
    @MainActor
    func testRefreshLocationWeather_shouldOverrideOutdatedWeatherData() async throws {
        // Given
        let weatherData = MockWeatherFetcher().data()
        
        let viewModel = LocationWeatherViewModel(location: MockLocation.london, weatherFetcher: FailingMockWeatherFetcher())
        viewModel.weather = weatherData
        
        XCTAssertNotNil(viewModel.weather)
        
        // When
        await viewModel.loadLocationWeather(refresh: true)
        
        // Then
        XCTAssertNil(viewModel.weather)
    }
}
