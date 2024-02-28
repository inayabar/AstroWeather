//
//  NetworkService.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func get<T>(request: NetworkRequest<T>) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func get<T>(request: NetworkRequest<T>) async throws -> T {
        let (data, response) = try await session.data(for: request.urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidUrlError
        }
        
        if !(200..<300 ~= response.statusCode) {
            throw NetworkError.httpError(statusCode: response.statusCode)
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(request.responseType, from: data)
        } catch {
            guard let error = error as? DecodingError else {
                throw error
            }
            
            throw NetworkError.decodingError(error)
        }
    }
}
