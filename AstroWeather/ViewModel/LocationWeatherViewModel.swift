//
//  WeatherViewModel.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

@MainActor
class LocationWeatherViewModel: ObservableObject {
    @Published var weather: WeatherData? = nil
    let location: Location
    
    private let weatherFetcher: WeatherFetcher
    
    
    init(location: Location, weatherFetcher: WeatherFetcher) {
        self.location = location
        self.weatherFetcher = weatherFetcher
    }
    
    func loadLocationWeather() async throws {
        do {
            let data = try await weatherFetcher.fetchWeather(for: location)
            weather = data
        }
    }
}
