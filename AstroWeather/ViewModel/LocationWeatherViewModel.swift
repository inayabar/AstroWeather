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
    private let weatherService: WeatherService = WeatherService(networkService: NetworkService())
    let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func loadLocationWeather() async throws {
        do {
            let data = try await weatherService.getWeather(for: location)
            weather = data
        }
    }
}
