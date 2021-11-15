//
//  WeatherModel.swift
//  Wezzr
//
//  Created by Dauren Omarov on 07.11.2021.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: String
    let conditionDescription: String
    let forecastTemp: [Double]
    let forecastDate: [String]
    let forecastDescription: [String]
    let forecastIcon: [String]
}
