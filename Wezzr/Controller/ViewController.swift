//
//  ViewController.swift
//  Wezzr
//
//  Created by Dauren Omarov on 07.11.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
//MARK: - Variables
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
//MARK: - Main Functionality
    override func viewDidLoad() {
        super.viewDidLoad()
        //Showing activity indicator while initial data loads up
        self.showSpinner()
        
        weatherManager.delegate = self
        locationManager.delegate = self
        searchTextField.delegate = self
        
        locationManager.requestWhenInUseAuthorization() //Permission request in case none was done before
        locationManager.requestLocation() //Request of current location
    }
    
    @IBAction func localizePressed(_ sender: UIButton) {
        locationManager.requestLocation()
        self.showSpinner()
    }
    
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) //Dismissing keyboard if Search button got pressed
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            self.showSpinner()
            weatherManager.fetchWeather(cityName: city, vc: self)
            self.removeSpinner() //Destroy spinner after data was fetched
        }
        
        searchTextField.text = ""
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            //Fetching data by coordinates
            weatherManager.fetchWeather(latitude: lat, longitude: lon, vc: self)
            self.removeSpinner()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.removeSpinner() //TODO: Include error pop-up if failed
    }
}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.weatherStatus.text = weather.conditionDescription.firstUppercased
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Uppercasing
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() } //To uppercase condition status of current weather
}
