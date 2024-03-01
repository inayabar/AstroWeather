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
    private let apiKey: String
    
    internal init(networkService: NetworkService) {
        self.networkService = networkService
        
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let apiKey = plist.object(forKey: "OPEN_WEATHER_API_KEY") as? String else {
            self.apiKey = ""
            return
        }

        self.apiKey = apiKey
    }
    
    func fetchWeather(for location: Location) async throws -> WeatherData {
        guard var url = APIs.OpenWeatherMap.weather(latitude: location.latitude, longitude: location.longitude, appId: apiKey).url else {
            throw NetworkError.invalidUrlError
        }
        
        let urlRequest = URLRequest(url: url)

        let request = NetworkRequest(urlRequest: urlRequest, responseType: WeatherData.self)
        
        return try await networkService.get(request: request)
    }
}
