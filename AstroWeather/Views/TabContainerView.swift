//
//  ContentView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct TabContainerView: View {
    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @State private var currentTab = 0
    
    var body: some View {
        if let coordinate = locationManager.coordinate {
            Text("Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)".uppercased())
        }
        
        TabView(selection: $currentTab,
                content:  {
            ForEach(Location.list.enumerated().map({$0}), id: \.element.id) { index, location  in
                LocationWeatherView(viewModel: viewModelFactory.makeLocationWeatherViewModel(for: location))
                    .tag(index)
            }
        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    TabContainerView()
        .environmentObject(ViewModelFactory())
}
