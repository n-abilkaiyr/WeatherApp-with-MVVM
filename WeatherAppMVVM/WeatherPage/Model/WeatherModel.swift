//
//  WeatherModel.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Float
    
    var conditonName: String {
        getconditionName()
    }
    
    var temperatureString: String {
        String(format: "%.0f", temperature)
    }
    
    private func getconditionName() -> String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
