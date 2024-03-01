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
                    WeatherSummaryView(locationName: viewModel.locationName, weather: weather, isCurrent: viewModel.isCurrentLocation)
                        .padding([.top, .bottom])
                    
                    HStack(spacing: 32) {
                        WeatherInfoContainer(title: "Humedad", systemImage: "humidity", content: {
                            Text("\(weather.humidity) %")
                                .font(.title2)
                        })
                        
                        WeatherInfoContainer(title: "Sensación", systemImage: "thermometer.transmission", content: {
                            Text("\(weather.feelsLike)º")
                                .font(.title2)
                        })
                    }
                    .padding([.horizontal, .bottom])
                    
                    HStack(spacing: 32) {
                        WeatherInfoContainer(title: "visibilidad", systemImage: "eye", content: {
                            VStack(alignment: .leading) {
                                Text("\(weather.formattedVisibility)")
                                    .font(.title2)
                                
                                Text(viewModel.visibilityDescription)
                                    .font(.caption)
                            }
                        })
                        
                        WeatherInfoContainer(title: "nubes", systemImage: "cloud", content: {
                            VStack {
                                Spacer()
                                
                                Text("\(weather.clouds.all) %")
                                    .font(.title2)
                                    .padding(.bottom)
                            }
                        })
                    }
                    .padding([.horizontal, .bottom])
                    
                    WindView(wind: weather.wind)
                        .padding([.horizontal, .bottom])
                    
                    if let sunrise = viewModel.sunrise, let sunset = viewModel.sunset {
                        HStack(spacing: 32) {
                            WeatherInfoContainer(title: "Amanecer", systemImage: "sunrise", content: {
                                Text(sunrise)
                                    .font(.title2)
                            })
                            
                            WeatherInfoContainer(title: "Atardecer", systemImage: "sunset", content: {
                                Text(sunset)
                                    .font(.title2)
                            })
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    WeatherSkeletonView(location: viewModel.location)
                }
            }
            .padding()
        }
        .foregroundColor(viewModel.isNight ? .white : .black)
        .background(viewModel.weather?.icon == nil ?  AnyView(Color.clear) : AnyView(Image(viewModel.weather?.icon ?? "")))
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
