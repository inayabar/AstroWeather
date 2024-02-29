//
//  WeatherView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct LocationWeatherView: View {
    @StateObject var viewModel: LocationWeatherViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                if let weather = viewModel.weather {
                    VStack(alignment: .center) {
                        HStack {
                            Text(weather.name)
                                .font(.title)
                                //.foregroundColor(.white)
                            
                            
                            if viewModel.isCurrentLocation() {
                                Image(systemName: "location")
                                    .font(.system(size: 20))
                            }
                        }
                        
                        Text("  \(weather.temperature)°")
                            .font(.system(size: 64))
                            .bold()
                        
                        if let description = weather.description {
                            Text(description.capitalized)
                        }
                    }
                    
                    HStack(spacing: 32) {
                        RoundedTranslucentBox {
                            VStack {
                                Text("Mínima")
                                    .font(.title2)
                                Text("\(weather.minimumTemperature)°")
                                    .font(.title)
                            }
                            .padding()
                        }
                        
                        RoundedTranslucentBox {
                            VStack {
                                Text("Máxima")
                                    .font(.title2)
                                
                                Text("\(weather.maximumTemperature)°")
                                    .font(.title)
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                    HStack(spacing: 32) {
                        RoundedTranslucentBox {
                            VStack {
                                Text("Visibilidad")
                                    .font(.title2)
                                Text("\(weather.formattedVisibility)")
                                    .font(.title)
                            }
                            .padding()
                        }
                        
                        RoundedTranslucentBox {
                            VStack {
                                Text("Nubes")
                                    .font(.title2)
                                
                                Text("\(weather.clouds.all) %")
                                    .font(.title)
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                    HStack(spacing: 32) {
                        RoundedTranslucentBox {
                            VStack {
                                Text("Viento")
                                    .font(.title2)
                                
                                Text("\(weather.wind.formattedSpeed)")
                                    .font(.title)
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                } else {
                    WeatherSkeletonView(location: viewModel.location)
                }
            }
            .padding()
        }
        .background(Image("13d"))
        .onAppear {
            Task {
                await viewModel.loadLocationWeather()
            }
        }
    }
}

#Preview {
    let viewModel = LocationWeatherViewModel(location: MockLocation.current, weatherFetcher: MockWeatherFetcher())
    return LocationWeatherView(viewModel: viewModel)
}
