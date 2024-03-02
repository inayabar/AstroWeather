//
//  WeatherViewModel.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 28/02/2024.
//

import Foundation

@MainActor
class LocationWeatherViewModel: ObservableObject {
    @Published var weather: WeatherData? = nil
    @Published var isShowingError: Bool = false
    @Published var errorMessage = ""
    @Published var location: Location
    
    private let weatherFetcher: WeatherFetcher
    private let dateFormatter = DateFormatter()
    private var weatherUpdatedAt: Date? = nil
    
    
    init(location: Location, weatherFetcher: WeatherFetcher) {
        self.location = location
        self.weatherFetcher = weatherFetcher
    }
    
    var isNight: Bool {
        guard let icon = weather?.icon else {
            return false
        }
        
        return icon.contains("n")
    }
    
    var locationName: String {
        return weather?.name ?? location.name
    }
    
    var isCurrentLocation: Bool {
        return location.isCurrent
    }
    
    var visibilityDescription: String {
        guard let visibility = weather?.visibility else {
            return ""
        }
        
        switch visibility {
        case 0..<1000:
            return "Muy poca visibilidad"
        case 1000..<3000:
            return "Visibilidad reducida"
        case 3000..<6000:
            return "Visibilidad moderada"
        case 6000...:
            return "Completamente despejada"
        default:
            return ""
        }
    }
    
    var sunrise: String? {
        guard let sunriseUnix = weather?.sys.sunrise else {
            return nil
        }
        
        let sunriseDate = Date(timeIntervalSince1970: sunriseUnix)
        return formatDateAsHourAndMinutes(sunriseDate)
    }
    
    var sunset: String? {
        guard let sunsetUnix = weather?.sys.sunset else {
            return nil
        }
        
        let sunsetDate = Date(timeIntervalSince1970: sunsetUnix)
        return formatDateAsHourAndMinutes(sunsetDate)
    }
    
    var lastWeatherUpdateFormatted: String {
        guard let updatedAt = weatherUpdatedAt else {
            return ""
        }
        
        return formatDateAsHourAndMinutes(updatedAt)
    }
    
    func loadLocationWeather(refresh: Bool = false) async {
        if weather != nil && !refresh {
            return
        }
        
        weather = nil
        
        do {
            let data = try await weatherFetcher.fetchWeather(for: location)
            weather = data
            weatherUpdatedAt = Date()
        } catch {
            handleErrorMessage(error)
        }
    }
    
    private func formatDateAsHourAndMinutes(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }
    
    private func handleErrorMessage(_ error: Error) {
        if let error = error as? NetworkError {
            switch error {
            case .httpError(let statusCode):
                self.errorMessage = "Esta ubicacion generó una solicitud invalida (Codigo http: \(statusCode))"
            case .decodingError(_):
                self.errorMessage = "Hubo un error recibiendo los datos del clima. Por favor, intenta de nuevo."
            case .invalidUrlError:
                self.errorMessage = "Esta ubicación genero una solicitud invalida. Por favor, intenta de nuevo."
            case .notConnectedToInternet:
                self.errorMessage = "¡Parece que estás desconectado! Por favor, compruebe la conexión y vuelva a intentarlo"
            }
        } else {
            self.errorMessage = "Ocurrió un error inesperado. Por favor, intenta de nuevo."
        }
        
        self.isShowingError = true
    }
}
