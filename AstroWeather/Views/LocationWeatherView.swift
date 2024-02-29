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
                    WeatherSummaryView(locationName: viewModel.locationName, weather: weather, isCurrent: viewModel.isCurrentLocation())
                    
                    HStack(spacing: 32) {
                        RoundedTranslucentBox {
                            VStack {
                                Text("Visibilidad")
                                    .font(.title2)
                                    .bold()
                                Text("\(weather.formattedVisibility)")
                                    .font(.title2)
                            }
                            .padding()
                        }
                        
                        RoundedTranslucentBox {
                            VStack {
                                Text("Nubes")
                                    .font(.title2)
                                    .bold()
                                
                                Text("\(weather.clouds.all) %")
                                    .font(.title2)
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
        .foregroundColor(viewModel.isNight ? .white : .black)
        .background(Image(viewModel.icon ?? ""))
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
