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
    @Published var isShowingError: Bool = false
    @Published var errorMessage = ""
    
    let location: Location
    
    private let weatherFetcher: WeatherFetcher
    
    
    init(location: Location, weatherFetcher: WeatherFetcher) {
        self.location = location
        self.weatherFetcher = weatherFetcher
    }
    
    func loadLocationWeather() async {
        do {
            let data = try await weatherFetcher.fetchWeather(for: location)
            weather = data
        } catch {
            handleErrorMessage(error)
        }
    }
    
    private func handleErrorMessage(_ error: Error) {
        if let error = error as? NetworkError {
            switch error {
            case .httpError(let statusCode):
                self.errorMessage = "This location created an invalid request. Please try again (http code: \(statusCode))"
            case .decodingError(let error):
                self.errorMessage = "There was an error while parsing the response. Please try again"
            case .invalidUrlError:
                self.errorMessage = "This location generated an invalid request. Please try again"
            case .notConnectedToInternet:
                self.errorMessage = "It seems like you are offline! Please check your connection and try again"
            }
        } else {
            self.errorMessage = "Oh no! Could not load more artworks. Please try again later"
        }
        
        self.isShowingError = true
    }
}
