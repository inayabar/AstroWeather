//
//  WeatherService.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

final class WeatherService {
    let networkService: NetworkService
    
    internal init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getWeather(for location: Location) async throws -> WeatherData {
        guard let url = APIs.OpenWeatherMap.weather(latitude: location.latitude, longitude: location.longitude).url else {
            throw NetworkError.invalidUrlError
        }
        
        let urlRequest = URLRequest(url: url)

        let request = NetworkRequest(urlRequest: urlRequest, responseType: WeatherData.self)
        
        return try await networkService.get(request: request)
    }
}
