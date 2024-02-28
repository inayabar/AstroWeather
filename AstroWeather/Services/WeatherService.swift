//
//  WeatherService.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

protocol WeatherFetcher {
    func fetchWeather(for: Location) async throws -> WeatherData
}

final class WeatherService: WeatherFetcher {
    let networkService: NetworkServiceProtocol
    
    internal init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchWeather(for location: Location) async throws -> WeatherData {
        guard let url = APIs.OpenWeatherMap.weather(latitude: location.latitude, longitude: location.longitude).url else {
            throw NetworkError.invalidUrlError
        }
        
        let urlRequest = URLRequest(url: url)

        let request = NetworkRequest(urlRequest: urlRequest, responseType: WeatherData.self)
        
        return try await networkService.get(request: request)
    }
}
