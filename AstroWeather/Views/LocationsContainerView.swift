//
//  ContentView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct LocationsContainerView: View {
    @ObservedObject var viewModel: LocationsViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(viewModel.locations.enumerated().map({$0}), id: \.element.id) { index, location  in
                LocationWeatherView(viewModel: viewModelFactory.makeLocationWeatherViewModel(for: location))
                    .tag(index)
            }
            .padding(.vertical)
        })
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    LocationsContainerView(viewModel: LocationsViewModel(locationManager: LocationManager()))
        .environmentObject(ViewModelFactory())
}
