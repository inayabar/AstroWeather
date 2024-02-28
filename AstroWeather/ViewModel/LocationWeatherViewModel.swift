//
//  WeatherViewModel.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

class LocationWeatherViewModel: ObservableObject {
    let location: Location
    
    init(location: Location) {
        self.location = location
    }
}
