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
    var coordinate: CLLocationCoordinate2D? { get set }
}

class LocationManager: NSObject, LocationManagerProtocol {
    weak var delegate: LocationManagerDelegate?
    let manager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D? = nil
    
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
        guard let location = locations.first else {
            return
        }
        
        coordinate = location.coordinate
        delegate?.didUpdateLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
    
        case .restricted, .denied:
            coordinate = nil
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

