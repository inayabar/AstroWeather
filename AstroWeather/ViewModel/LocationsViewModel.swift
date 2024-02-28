//
//  LocationsViewModel.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation
import CoreLocation

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private var locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
        loadLocations()
    }
    
    private func loadLocations() {
        var locations: [Location] = []
        if let coordinate = locationManager.coordinate {
            locations.append(Location(id: UUID(), name: "Current location", latitude: coordinate.latitude.magnitude, longitude: coordinate.longitude.magnitude))
        }
        
        locations.append(contentsOf: Location.list)
        
        self.locations = locations
    }
}

extension LocationsViewModel: LocationManagerDelegate {
    func didUpdateLocation() {
        self.loadLocations()
    }
}
