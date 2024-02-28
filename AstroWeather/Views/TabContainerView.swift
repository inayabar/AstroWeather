//
//  ContentView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct TabContainerView: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(Location.list.enumerated().map({$0}), id: \.element.id) { index, location  in
                LocationWeatherView(viewModel: LocationWeatherViewModel(location: location))
                    .tag(index)
            }
        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    TabContainerView()
}
