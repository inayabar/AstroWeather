//
//  NetworkRequest.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

struct NetworkRequest<T: Decodable> {
    let urlRequest: URLRequest
    let responseType: T.Type
}
