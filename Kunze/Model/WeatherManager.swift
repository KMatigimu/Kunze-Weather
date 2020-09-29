//
//  WeatherManager.swift
//  Kunze
//
//  Created by Kudzaishe Mhou on 2020/09/07.
//  Copyright © 2020 Kudakwashe Matigimu. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func  didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel)
    func didFailWithError(error: Error)
    
}



struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=042acebb05a68e8c2103fc6294b3a270&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather (cityName: String){
        let replaced = (cityName as NSString).replacingOccurrences(of: " ", with: "+")
        let urlString = "\(weatherURL)&q=\(replaced)"
        performRequest(with: urlString)
    }
    
    func fetchWeather (latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    //Networking Method
    func performRequest (with urlString: String){
        if let  url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let main = decodedData.weather[0].main
            let dt = decodedData.dt
            
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, main: main, dat: dt)
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


