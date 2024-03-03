//
//  MockWeatherFetcher.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import Foundation

struct MockWeatherFetcher: WeatherFetcher {
    func data() -> WeatherData {
        let fileURL = Bundle.main.url(forResource: "mock_weather_data", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(WeatherData.self, from: data)
    }
    
    func fetchWeather(for: Location) async throws -> WeatherData {
        return data()
    }
}

struct FailingMockWeatherFetcher: WeatherFetcher {
    func fetchWeather(for: Location) async throws -> WeatherData {
        throw NetworkError.notConnectedToInternet
    }
}
