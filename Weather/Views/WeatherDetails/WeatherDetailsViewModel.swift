//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by Srdjan Dobrota on 17.3.25..
//

import Foundation

class WeatherDetailsViewModel: ObservableObject {
    
    var city: CityWeather
    
    init(city: CityWeather) {
        self.city = city
    }
}
