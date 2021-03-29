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
                Text(city).font(.title)
                Spacer()
                TextField("City", text: $viewModel.cityName).font(.largeTitle)
            }.padding().border(Color.black, width: 2)

            
            HStack{
                Text(temperature).font(.title)
                Spacer()
                Text(viewModel.temperature).font(.system(size: 45)).bold()
            }.padding().border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
            
//            Text(viewModel.weatherIcon).font(.largeTitle).padding()
//            Text(viewModel.weatherDescripition)
        }.onAppear(perform: {
            viewModel.refresh()
        })
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
}
