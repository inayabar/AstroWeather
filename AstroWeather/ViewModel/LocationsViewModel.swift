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
    private var currentCoordinate: CLLocationCoordinate2D? = nil
    private var locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
        loadLocations()
    }
    
    private func loadLocations() {
        var locations: [Location] = []
        if let coordinate = locationManager.coordinate {
            locations.append(Location(isCurrent: true, id: UUID(), name: "Current location", latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        
        locations.append(contentsOf: Location.list)
        
        self.locations = locations
    }
}

extension LocationsViewModel: LocationManagerDelegate {
    func didUpdateLocation() {
        guard let newCoordinate = locationManager.coordinate else {
            return
        }
        
        if let oldCoordinate = self.currentCoordinate, oldCoordinate.latitude != newCoordinate.latitude || oldCoordinate.longitude != newCoordinate.longitude {
            self.currentCoordinate = newCoordinate
            self.loadLocations()
        }
    }
}
