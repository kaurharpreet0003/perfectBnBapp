//
//  ContentView.swift
//  Weather
//
//  Created by Syed Nooruddin Fahad on 06/03/21.
//

import SwiftUI

struct WeatherView: View {
    
    @State var city = "City Name:"
    @State var temperature = "Temperature:"
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(city).font(.title).padding()
                Text(viewModel.cityName).font(.largeTitle).bold().padding()
            }
            
//            HStack{
//                Text(temperature).font(.title)
//                Text(viewModel.temperature).font(.system(size: 45)).bold().padding()
//            }
            
//            Text(viewModel.weatherIcon).font(.largeTitle).padding()
//            Text(viewModel.weatherDescripition)
        }.onAppear(perform: {
            viewModel.refresh()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
