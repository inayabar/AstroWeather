//
//  WindView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct WindView: View {
    let wind: WeatherData.Wind
    
    var body: some View {
        HStack(spacing: 32) {
            RoundedTranslucentBox {
                HStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Label("Viento", systemImage: "wind")
                            .font(.subheadline)
                            .padding(.bottom)
                            .padding(.trailing)
                        HStack {
                            Text(String(format: "%.1f", wind.speed))
                                .font(.title)
                                .bold()
                            
                            Text("km/h")
                                .font(.subheadline)
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    CompassView(directionDegrees: Double(wind.deg))
                        .frame(width: 80, height: 80)
                        .padding(.trailing, 20)
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    WindView(wind: WeatherData.Wind(speed: 30, deg: 33, gust: nil))
}
