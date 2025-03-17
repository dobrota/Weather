//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Srdjan Dobrota on 17.3.25..
//

import SwiftUI

struct WeatherDetailsView: View {
    
    @StateObject var viewModel: WeatherDetailsViewModel

    var body: some View {
        VStack {
            Text(viewModel.city.name).font(.largeTitle)
            AsyncImage(url: URL(string: viewModel.city.weather.first?.iconURL2x ?? ""))
            { image in
                image
            } placeholder: {
                ProgressView()
            }
            Text(String(viewModel.city.weather.first?.main ?? "") + " - " + String(viewModel.city.weather.first?.description ?? "") ).font(.subheadline)
            Text(String(viewModel.city.main.temp) + " °C").font(.largeTitle).padding()
            Text("Feels like: " + String(viewModel.city.main.feelsLike) + " °C").font(.subheadline).padding()
            Text("High: " + String(viewModel.city.main.tempMax) + " °C").font(.title2)
            Text("Low: " + String(viewModel.city.main.tempMin) + " °C").font(.title2)
            Spacer()
        }
    }
}
