//
//  ContentView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct TabContainerView: View {
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    @State private var currentTab = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $currentTab,
                        content:  {
                    ForEach(Location.list.enumerated().map({$0}), id: \.element.id) { index, location  in
                        LocationWeatherView(viewModel: viewModelFactory.makeLocationWeatherViewModel(for: location))
                            .tag(index)
                    }
                })
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                HStack {
                    Spacer()
                    NavigationLink(destination: {
                        LocationListView()
                    }, label: {
                        Label("", systemImage: "list.dash")
                    })
                    .padding([.trailing, .bottom])
                }
            }
        }
    }
}

#Preview {
    TabContainerView()
        .environmentObject(ViewModelFactory())
}
