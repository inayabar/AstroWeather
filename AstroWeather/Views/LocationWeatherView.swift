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
        Text(viewModel.location.name)
    }
}

#Preview {
    let viewModel = LocationWeatherViewModel(location: Location.list.first!)
    return LocationWeatherView(viewModel: viewModel)
}
