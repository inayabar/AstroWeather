//
//  LocationsViewModel.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation
import CoreLocation

final class LocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private var currentLocation: CLLocation? = nil
    private var locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
        loadLocations()
    }
    
    private func loadLocations() {
        var locations: [Location] = []
        if let currentLocation = locationManager.currentLocation {
            locations.append(Location(isCurrent: true, id: UUID(), name: "Current location", latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
            self.currentLocation = currentLocation
        }
        
        locations.append(contentsOf: Location.list)
        
        self.locations = locations
    }
}

extension LocationsViewModel: LocationManagerDelegate {
    func didUpdateLocation() {
        guard let newLocation = locationManager.currentLocation else {
            return
        }
        
        self.loadLocations()
    }
}
