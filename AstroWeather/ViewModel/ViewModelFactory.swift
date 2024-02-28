//
//  ViewModelFactory.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation


class ViewModelFactory: ObservableObject {
    let weatherFetcher: WeatherFetcher = WeatherService(networkService: NetworkService())
    let locationManager: LocationManager = LocationManager()
    
    @MainActor
    func makeLocationWeatherViewModel(for location: Location) -> LocationWeatherViewModel {
        return LocationWeatherViewModel(location: location, weatherFetcher: weatherFetcher)
    }
    
    @MainActor
    func makeLocationsViewModel() -> LocationsViewModel {
        return LocationsViewModel(locationManager: locationManager)
    }
}
