//
//  ForecastModel.swift
//  Wezzr
//
//  Created by Dauren Omarov on 12.11.2021.
//

import Foundation

struct Forecast {
    let day: String
    let forecastId: Int
    let forecastTemp: String
    
    var forecastStatusCode: String {
        switch forecastId {
        case 200...232:
            return "cloud.filled"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
