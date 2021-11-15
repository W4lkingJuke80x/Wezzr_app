//
//  ForecastData.swift
//  Wezzr
//
//  Created by Dauren Omarov on 13.11.2021.
//

import Foundation

struct ForecastData: Decodable{
    var location: Location
    var current: Current
    var forecast: Forecast
}

struct Location: Decodable {
    var name: String = ""
}

struct Current: Decodable {
    var temp_c: Int = 1
    var condition: CurrentCondition
}

struct CurrentCondition: Decodable {
    var text: String = ""
    var code: Int = 0
}

struct Forecast: Decodable {
    var forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    var date: String = ""
    var day: DayData
}

struct DayData: Decodable {
    var avgtemp_c: Double = 0.0
    var condition: DayCondition
}

struct DayCondition: Decodable {
    var text: String = ""
    var code: Int = 0
}
