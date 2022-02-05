//
//  WeatherViewModel.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import Foundation

protocol WeatherViewControllerDelegate {
    func fetchCurrentLocationWeather()
    func fetchWeather(for cityName: String)
}
protocol WeatherViewModelProtocol {
    func fetchCurrentLocationWeather(completion: @escaping (WeatherModel) -> Void)
    func fetchWeather(by cityName: String, completion: @escaping (WeatherModel) -> Void)
}


class WeatherViewModel: WeatherViewModelProtocol {
    func fetchCurrentLocationWeather(completion: @escaping (WeatherModel) -> Void) {
        LocationManager.shared.completion = { lat, lon in
            NetworkManager.shared.fetchWeather(longitude: lon, latitude: lat) { result in
                switch result {
                case .success(let weather):
                    completion(weather)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        LocationManager.shared.fetchLocation()
    }
    
   
    func fetchWeather(by cityName: String, completion: @escaping (WeatherModel) -> Void) {
        NetworkManager.shared.fetchWeather(cityName: cityName) { result in
            
            switch result {
            case .success(let weatherModel):
                completion(weatherModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
