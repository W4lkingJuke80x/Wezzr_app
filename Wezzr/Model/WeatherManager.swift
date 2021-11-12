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
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3bd61a0b4be33b251d2172e3a57cb79a&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
//MARK: - FetchWeather for cityName and coordinates
    func fetchWeather(cityName: String, vc: UIViewController) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString, vcForAlert: vc)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, vc: UIViewController) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(with: urlString, vcForAlert: vc)
    }

//MARK: - PerformRequest Function
    func performRequest(with urlString: String, vcForAlert: UIViewController) {
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
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let desc = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, conditionDescription: desc)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

