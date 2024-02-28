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
}
