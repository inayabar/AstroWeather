//
//  API.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

enum APIs {
    enum OpenWeatherMap {
        case weather(latitude: Double, longitude: Double)
        
        private var baseURL: String {
            switch self {
            case .weather(let latitude, let longitude):
                return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\("9f023bcc4b89fa9fee4cbac24257bb73")&lang=es&units=metric" // TODO: API KEY
            }
        }
        
        var url: URL? {
            URL(string: baseURL)
        }
    }
}
