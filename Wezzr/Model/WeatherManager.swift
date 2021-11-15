//
//  WeatherManager.swift
//  Wezzr
//
//  Created by Dauren Omarov on 07.11.2021.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.weatherapi.com/v1/forecast.json?key=faac56db640a46acb2d122330211211&aqi=no&alerts=no&days=4"
    
    var finalWeather: WeatherModel?
    
    var delegate: WeatherManagerDelegate?
    
    var weatherResult: WeatherModel?
    
//MARK: - FetchWeather for cityName and coordinates
    func fetchWeather(cityName: String, vc: UIViewController) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, vc: UIViewController) {
        let urlString = "\(weatherURL)&q=\(latitude),\(longitude)"
        
        performRequest(with: urlString)
    }

//MARK: - PerformRequest Function
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                } else {
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        // Data is passed here
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

//MARK: - ParseJSON Function
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        let weather: WeatherModel
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: weatherData)
            let id = decodedData.current.condition.code
            let name = decodedData.location.name
            let temp = String(decodedData.current.temp_c)
            let currentDesc = decodedData.current.condition.text
            
            var fTemp: [Double] = []
            var fDate: [String] = []
            var fDesc: [String] = []
            var fIconCode: [Int] = []
            var fIconText: [String] = []
            for n in 1...2 {
                //Get current weekday index
                let convertedDate = getDayOfWeek(today: decodedData.forecast.forecastday[n].date)
                
                fTemp.append(decodedData.forecast.forecastday[n].day.avgtemp_c)
                fDate.append(convertedDate)
                fDesc.append(decodedData.forecast.forecastday[n].day.condition.text)
                fIconCode.append(decodedData.forecast.forecastday[n].day.condition.code)
            }
            
            // Convert [Int] into [String]
            fIconText = codeToText(codeArray: fIconCode)
            
            weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, conditionDescription: currentDesc, forecastTemp: fTemp, forecastDate: fDate, forecastDescription: fDesc, forecastIcon: fIconText)
            
            return weather
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getDayOfWeek(today: String) -> String{
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)
        formatter.dateFormat = "eeee"
        let weekDay = formatter.string(from: todayDate!)
        return weekDay
    }
}

func codeToText(codeArray: [Int]) -> [String] {
    var textArray: [String] = []
    for index in 0...1 {
        textArray.append(checkArray(codeArray: codeArray, index: index))
    }
    return textArray
}

func checkArray(codeArray: [Int], index: Int) -> String {
    switch codeArray[index] {
    case 1000:
        return "sun.max"
    case 1003...1009:
        return "cloud.fill"
    case 1030:
        return "cloud.fog"
    case 1063, 1180...1189:
        return "cloud.rain"
    case 1066, 1210...1213:
        return "cloud.snow"
    case 1069, 1204:
        return "cloud.sleet"
    case 1072, 1150...1153:
        return "cloud.drizzle"
    case 1168...1191:
        return "cloud.drizzle.fill"
    case 1192...1214:
        return "cloud.rain.fill"
    case 1215:
        return "cloud.sleet.fill"
    case 1216...1239:
        return "cloud.snow.fill"
    case 1240...1252:
        return "cloud.heavyrain"
    case 1255...1264:
        return "cloud.snow.fill"
    case 1273...1276:
        return "cloud.bolt.rain.fill"
    case 1279...1282:
        return "cloud.snow.fill"
    default:
        return "sun"
    }
}
