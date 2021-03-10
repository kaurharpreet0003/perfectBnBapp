//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Syed Nooruddin Fahad on 06/03/21.
//

import Foundation

//private let defaultIcon = "?"
//private let iconMap = [ "Drizzle" : "🌧",
//                        "Thunderstorm" : "🌧",
//                        "Rain" : "🌧",
//                        "Snow" : "❄️",
//                        "Clear" : "☀️",
//                        "Clouds" : "☁️",
//                        "Haze":"🌫"]

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "__"
//    @Published var weatherDescripition: String = "__"
//    @Published var weatherIcon: String = defaultIcon
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData{ weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
//                self.weatherDescripition = weather.description.capitalized
//                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
