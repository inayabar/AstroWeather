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
    private let wind: Wind
    private let clouds: Clouds
    private let dt: Int
    private let timezone: Int
    let name: String
    
    var description: String? {
        return weather.first?.description
    }
    
    var temperature: Int {
        return Int(main.temp)
    }
    
    var min: Int {
        return Int(main.tempMin)
    }
    
    var max: Int {
        return Int(main.tempMax)
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
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
    struct Sys: Decodable {
        let sunrise: Int
        let sunset: Int
    }
}
