//
//  LocationDataManager.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var coordinate: CLLocationCoordinate2D? = nil
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        coordinate = location.coordinate
    }
}
