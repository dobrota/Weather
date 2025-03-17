//
//  City.swift
//  Weather
//
//  Created by Srdjan Dobrota on 17.3.25..
//

class City: Identifiable {
    var id : Int
    var name: String
    var isSelected: Bool
    
    init(id: Int, name: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
