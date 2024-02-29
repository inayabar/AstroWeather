//
//  AstroWeatherApp.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

@main
struct AstroWeatherApp: App {
    let viewModelFactory = ViewModelFactory()
    
    var body: some Scene {
        WindowGroup {
            LocationsContainerView(viewModel: viewModelFactory.makeLocationsViewModel())
                .environmentObject(viewModelFactory)
        }
    }
}
