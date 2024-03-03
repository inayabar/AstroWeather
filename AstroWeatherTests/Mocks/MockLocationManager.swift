//
//  MockLocationManager.swift
//  AstroWeatherTests
//
//  Created by Iñaki Yabar Bilbao on 02/03/2024.
//

import Foundation
import CoreLocation
@testable import AstroWeather

final class MockLocationManager: LocationManagerProtocol {
    var delegate: AstroWeather.LocationManagerDelegate?
    var coordinate: CLLocationCoordinate2D? = nil
    
    func updateLocation() {
        delegate?.didUpdateLocation()
    }
}
