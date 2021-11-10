//
//  WeatherData.swift
//  Wezzr
//
//  Created by Dauren Omarov on 07.11.2021.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
