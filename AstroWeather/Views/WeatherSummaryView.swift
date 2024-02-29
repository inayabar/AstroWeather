//
//  WeatherSummaryView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct WeatherSummaryView: View {
    let locationName: String
    let weather: WeatherData
    let isCurrent: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(locationName)
                    .font(.system(size: 32))
                
                if isCurrent {
                    Image(systemName: "location")
                        .font(.system(size: 20))
                }
            }
            
            Text("  \(weather.temperature)°")
                .font(.system(size: 100))
                .fontWeight(.thin)
            
            if let description = weather.description {
                Text(description.capitalized)
            }
            
            Text("Máxima: \(weather.maximumTemperature)º Mínima: \(weather.minimumTemperature)º")
        }
    }
}

#Preview {
    let mockWeather = MockWeatherFetcher().data()
    return WeatherSummaryView(locationName: "Buenos Aires", weather: mockWeather, isCurrent: true)
}
