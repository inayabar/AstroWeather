//
//  ContentView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct TabContainerView: View {
    private let locations: [Location] = [
        Location(id: UUID(), name: "London", latitude: 51.5074, longitude: -0.1278),
        Location(id: UUID(), name: "Buenos Aires", latitude: -34.6037, longitude: -58.3816),
        Location(id: UUID(), name: "Montevideo", latitude: -34.9011, longitude: -56.1645),
        Location(id: UUID(), name: "New York", latitude: 40.7128, longitude: -74.0060),
        Location(id: UUID(), name: "Tokyo", latitude: 35.6895, longitude: 139.6917)
    ]
    
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(locations.enumerated().map({$0}), id: \.element.id) { index, location  in
                Text(location.name)
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
