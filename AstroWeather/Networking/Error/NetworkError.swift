//
//  NetworkError.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

public enum NetworkError: Error {
    case httpError(statusCode: Int)
    case decodingError(Error)
    case invalidUrlError
    case notConnectedToInternet
}
