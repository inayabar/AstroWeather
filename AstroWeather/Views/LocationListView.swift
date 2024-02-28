//
//  LocationListView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        List(Location.list) { location in
            Text(location.name)
        }
        .navigationTitle("Locations")
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button("Add location", systemImage: "plus", action: {})
            }
        })
    }
}

#Preview {
    LocationListView()
}
