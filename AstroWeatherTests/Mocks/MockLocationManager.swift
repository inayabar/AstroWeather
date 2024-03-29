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
    var currentLocation: CLLocation?
    var delegate: AstroWeather.LocationManagerDelegate?
    
    func updateLocation() {
        delegate?.didUpdateLocation()
    }
}
