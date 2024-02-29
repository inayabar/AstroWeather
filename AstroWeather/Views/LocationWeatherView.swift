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
                        RoundedTranslucentBox {
                            VStack(alignment: .leading) {
                                Label("VISIBILIDAD", systemImage: "eye")
                                    .font(.subheadline)
                                    .padding(.bottom)
                                
                                Text("\(weather.formattedVisibility)")
                                    .font(.title2)
                                
                                Text(viewModel.visibilityDescription)
                                    .font(.caption)
                            }
                            .padding()
                        }
                        
                        RoundedTranslucentBox {
                            VStack(alignment: .leading) {
                                Label("NUBES", systemImage: "cloud")
                                    .font(.subheadline)
                                    .padding(.bottom)
                                    .padding(.trailing)
                                
                                Spacer()
                                
                                Text("\(weather.clouds.all) %")
                                    .font(.title2)
                                    .padding(.bottom)
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                    WindView(wind: weather.wind)
                    
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
