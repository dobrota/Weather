//
//  WeatherListView.swift
//  Weather
//
//  Created by Srdjan Dobrota on 16.3.25..
//

import SwiftUI

struct WeatherListView: View {
    @StateObject private var viewModel = WeatherListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Snap Weather").font(.headline)
                if (viewModel.citiesData.isEmpty) {
                    ProgressView().frame(maxHeight: .infinity)
                } else {
                    List(viewModel.citiesData, id: \.id) { city in
                        let detailsViewModel = WeatherDetailsViewModel(city: city)
                        NavigationLink(destination: WeatherDetailsView(viewModel: detailsViewModel)) {
                            VStack(alignment: .leading) {
                                Text(city.name + ", " + city.sys.country).font(.headline)
                                HStack {
                                    AsyncImage(url: URL(string: city.weather.first?.iconURL ?? ""))
                                    { image in
                                        image
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(String(city.main.temp) + " °C")
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .onAppear {
                viewModel.getWeather()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    let viewModel = AddRemoveViewModel(citiesArray: viewModel.citiesArray)
                    NavigationLink(destination: AddRemoveView(viewModel: viewModel)){
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherListView()
}
