//
//  ViewController.swift
//  Kunze
//
//  Created by Kudzaishe Mhou on 2020/09/07.
//  Copyright © 2020 Kudakwashe Matigimu. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var celsiusFahrenheit: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var weatherModel: WeatherModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

    
   @IBAction func celciusFahrenheit(_ sender: UISegmentedControl) {
        
    
    /*if sender.selectedSegmentIndex == 0 {
     
        
    }else {
        
       
    }*/
        /*switch (sender.selectedSegmentIndex)
        {
        case 0:
            celsiusFahrenheit.text = "C"
            
        case 1:
             celsiusFahrenheit.text = "F"
        default:
            break
        }*/
        
        
    }
    
    
    
    func celFahr (){
    
        
    }
    
    @IBAction func onSwitch(_ sender: Any) {
        switch (self.segmentedControl.selectedSegmentIndex){
            
        case 0: self.celsiusFahrenheit.text = "C"
        self.mainTempLabel.text = self.weatherModel?.temperatureStringCelsius
        case 1:self.celsiusFahrenheit.text = "F"
        self.mainTempLabel.text = weatherModel?.temperatureStringFarenheit
            
        default:
            break
        }
    }
    
}
//MARK:- UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
              return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
      }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK:- WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel){
        
        weatherModel = weather
        
         DispatchQueue.main.async {
            
            
           /* if self.segmentedControl.selectedSegmentIndex == 0 {
                   self.celsiusFahrenheit.text = "C"
                self.mainTempLabel.text = weather.temperatureString
                print("Celsius pressed")
                
                
            }else  {
                
                self.celsiusFahrenheit.text = "F"
                self.mainTempLabel.text = weather.celsiusToFahreinheit
                print("Fahrenheit pressed")
            }*/ 
            
            switch (self.segmentedControl.selectedSegmentIndex){
                
            case 0: self.celsiusFahrenheit.text = "C"
                    self.mainTempLabel.text = weather.temperatureStringCelsius
            case 1:self.celsiusFahrenheit.text = "F"
                   self.mainTempLabel.text = weather.temperatureStringFarenheit
                
            default:
                break
            }
            
            self.dateLabel.text = weather.timeString
             self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.conditionLabel.text = weather.main
            
            
         }
      
     }
     
     func didFailWithError(error: Error) {
         print(error)
     }
    
}

//MARK:- CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

