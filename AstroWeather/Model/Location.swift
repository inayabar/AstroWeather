//
//  Location.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation
struct Location: Identifiable, Hashable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    
    static let list: [Location] = [
        Location(id: UUID(), name: "London", latitude: 51.5074, longitude: -0.1278),
        Location(id: UUID(), name: "Buenos Aires", latitude: -34.6134, longitude: -58.3772),
        Location(id: UUID(), name: "Montevideo", latitude: -34.8335, longitude: -56.1674),
        Location(id: UUID(), name: "New York", latitude: 40.7128, longitude: -74.0060),
        Location(id: UUID(), name: "Tokyo", latitude: 35.6895, longitude: 139.6917)
    ]
}
