//
//  ViewModelFactory.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
    func makeLocationWeatherViewModel(for location: Location) -> LocationWeatherViewModel {
        return LocationWeatherViewModel(location: location)
    }
}
