//
//  AddRemoveView.swift
//  Weather
//
//  Created by Srdjan Dobrota on 17.3.25..
//

import SwiftUI

struct AddRemoveView: View {
    
    @StateObject var viewModel: AddRemoveViewModel
    @State var selected: Binding<Set<Int>>? = nil
    
    var body: some View {
        VStack {
            Text("Select Cities").font(.headline)
            if ($viewModel.citiesArray.isEmpty) {
                ProgressView().frame(maxHeight: .infinity)
            } else {
                List(viewModel.citiesArray, selection: selected) { city in
                    Label(city.name, systemImage: city.isSelected ? "checkmark.circle" : "circle")
                        .onTapGesture {
                            viewModel.selectCity(cityID: city.id)
                        }
                }.listStyle(InsetGroupedListStyle())
            }
        }
    }
    
}
