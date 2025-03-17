//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Srdjan Dobrota on 16.3.25..
//

import Foundation
import Combine

class WeatherListViewModel: ObservableObject {
    
    @Published var citiesArray = [City(id: 5391959, name: "San Francisco, US", isSelected: true), City(id: 5128638, name: "New York, US", isSelected: true), City(id: 5780993, name: "Salt Lake City, US", isSelected: true), City(id: 2643743, name: "London, GB", isSelected: false), City(id: 792680, name: "Belgrade, RS", isSelected: false), City(id: 264371, name: "Athens, GR", isSelected: false)]
    
    @Published var citiesData: [CityWeather] =  []
    
    private let client = APIClient()
    
    func getWeather() {
        client.request(url: client.urlBuilder(cityIds: getIDsFromCities())) { (result: Result<WeatherResponse, APIError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    self.citiesData = data.list
                }
            case .failure(let error):
                print("Failed to get datas: \(error)")
            }
        }
    }
    
    //Returns string with all city ids, separated by ","
    func getIDsFromCities() -> String {
        var data = ""
        let filteredCities = citiesArray.filter { $0.isSelected == true }
        for i in 0...filteredCities.count - 1 {
            data = data + String(filteredCities[i].id)
            if i < filteredCities.count - 1 {
                data = data + ","
            }
        }
        
        return data
    }
}
