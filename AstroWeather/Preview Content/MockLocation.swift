//
//  MockLocation.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import Foundation
struct MockLocation {
    static let current = Location(isCurrent: true, id: UUID(), name: "Buenos Aires", latitude: -34.6134, longitude: -58.3772)
    static let london = Location(id: UUID(), name: "London", latitude: 51.5074, longitude: -0.1278)
}
