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
    let temperature: Double
    let conditionDescription: String
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
}

