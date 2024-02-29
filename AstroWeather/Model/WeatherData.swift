//
//  WeatherData.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

struct WeatherData: Decodable {
    private let weather: [Weather]
    private let main: Main
    private let visibility: Int
    private let dt: Int
    private let timezone: Int
    let sys: Sys
    let wind: Wind
    let clouds: Clouds
    let name: String
    
    
    var description: String? {
        return weather.first?.description
    }
    
    var temperature: Int {
        return Int(main.temp)
    }
    
    var minimumTemperature: Int {
        return Int(main.tempMin)
    }
    
    var maximumTemperature: Int {
        return Int(main.tempMax)
    }
    
    var icon: String? {
        return weather.first?.icon
    }
    
    var formattedVisibility: String {
        let visibilityInKilometers = Double(visibility) / 1000.0
        return String(format: "%.1f km", visibilityInKilometers)
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
        
        var formattedSpeed: String {
            return String(format: "%.1f km/h", speed)
        }
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
    struct Sys: Decodable {
        let sunrise: Double
        let sunset: Double
    }
}
