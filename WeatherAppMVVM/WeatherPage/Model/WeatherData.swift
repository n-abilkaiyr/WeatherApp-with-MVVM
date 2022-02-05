//
//  WeatherData.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Main: Decodable {
    let temp: Float
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
