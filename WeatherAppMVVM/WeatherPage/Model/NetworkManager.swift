//
//  NetworkManager.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import Foundation
import CoreLocation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeather(cityName: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = "\(WeatherURL.baseURL)&q=\(cityName)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(error!))
            }
            if let data = data,
               let weatherModel = self.parseJSON(from: data) {
                DispatchQueue.main.async {
                    completion(.success(weatherModel))
                }
            }
        }.resume()
    }
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        
        let urlStirng = "\(WeatherURL.baseURL)&lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlStirng) else { return }
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }
            
            if let safeData = data,
               let weatherModel = self.parseJSON(from: safeData) {
                    DispatchQueue.main.async {
                        completion(.success(weatherModel))
                    }
                }
        }.resume()
    }
    
    func parseJSON(from data: Data) -> WeatherModel? {
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            let conditionId = weatherData.weather[0].id
            let cityname = weatherData.name
            let temp = weatherData.main.temp
            
            return WeatherModel(conditionId: conditionId,
                                            cityName: cityname,
                                            temperature: temp)
        } catch {
            let errorData = try! JSONDecoder().decode(ErrorData.self, from: data)
            print("\(errorData.cod): \(errorData.message)")
            return nil
        }
    }
}
