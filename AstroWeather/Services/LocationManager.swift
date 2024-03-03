//
//  LocationDataManager.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation()
}

protocol LocationManagerProtocol {
    var delegate: LocationManagerDelegate? { get set }
    var currentLocation: CLLocation? { get set }
}

class LocationManager: NSObject, LocationManagerProtocol {
    weak var delegate: LocationManagerDelegate?
    let manager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else {
            return
        }
        
        guard let currentLocation = currentLocation else {
            self.currentLocation = newLocation
            delegate?.didUpdateLocation()
            return
        }
        
        let distance = newLocation.distance(from: currentLocation)
        
        if distance >= kCLLocationAccuracyThreeKilometers {
            self.currentLocation = newLocation
            delegate?.didUpdateLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            break
    
        case .restricted, .denied:
            currentLocation = nil
            delegate?.didUpdateLocation()
            break
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
}

