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
            if let weather = viewModel.weather {
                VStack {
                    Text("\(weather.main.temp)°")
                        .font(.largeTitle)
                        .bold()
                    
                    Text(viewModel.location.name)
                }
            } else {
                Text(viewModel.location.name)
            }
        }
        .onAppear {
            Task {
                try! await viewModel.loadLocationWeather()
            }
        }
    }
}

#Preview {
    let viewModel = LocationWeatherViewModel(location: Location.list.first!, weatherFetcher: WeatherService(networkService: NetworkService()))
    return LocationWeatherView(viewModel: viewModel)
}
