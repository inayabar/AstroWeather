//
//  MockWeatherFetcher.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import Foundation

struct MockWeatherFetcher: WeatherFetcher {
    func fetchWeather(for: Location) async throws -> WeatherData {
        guard let fileURL = Bundle.main.url(forResource: "mock_weather_data", withExtension: "json") else {
            print("Could not find mock_weather_data")
            throw fatalError()
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            throw error
        }
    }
}
