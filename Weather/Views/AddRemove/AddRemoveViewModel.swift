//
//  AddRemoveViewModel.swift
//  Weather
//
//  Created by Srdjan Dobrota on 17.3.25..
//

import Foundation
import Combine

class AddRemoveViewModel: ObservableObject {
    
    @Published var isMetric = true
    @Published var citiesArray: [City]
    
    init(citiesArray: [City]) {
        self.citiesArray = citiesArray
    }
    
    //Here city.isSelected property is getting toggled, and because it is a reference it is automatic on our main viewModel
    func selectCity(cityID: Int) {
        if let index = citiesArray.firstIndex(where: { $0.id == cityID }) {
            let editedItem = citiesArray[index]
            editedItem.isSelected.toggle()
            citiesArray[index] = editedItem
        }
    }
}
