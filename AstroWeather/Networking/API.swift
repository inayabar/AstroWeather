//
//  API.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

enum APIs {
    enum OpenWeatherMap {
        case weather(latitude: Double, longitude: Double, languaje: String, appId: String)
        
        private var baseURL: String {
            switch self {
            case .weather(let latitude, let longitude, let languaje, let appId):
                return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(appId)&lang=\(languaje)&units=metric"
            }
        }
        
        var url: URL? {
            URL(string: baseURL)
        }
    }
}
