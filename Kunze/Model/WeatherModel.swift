//
//  WeatherModel.swift
//  Kunze
//
//  Created by Kudzaishe Mhou on 2020/09/09.
//  Copyright © 2020 Kudakwashe Matigimu. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let main: String
    let dat: Double
    
    var temperatureStringCelsius: String{
        return String(format: "%.0f", temperature)
    }
    
    var temperatureStringFarenheit: String {
          return String(format: "%.0f", (temperature * (9/5) + 32))
    }
    
    var conditionName: String {
        switch conditionId {
                    case 200...232:
                         return "cloud.bolt"
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
    
    func timeConverter(dat: Double) -> String {
      let dateAndTime = NSDate(timeIntervalSince1970: dat)
      let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
      dateFormater.timeStyle = .short
      dateFormater.locale = Locale.autoupdatingCurrent
      let currentdateAndTime = dateFormater.string(from: dateAndTime as Date)
      return currentdateAndTime
    }
    var timeString: String{
        return timeConverter(dat: dat)
        
    }
   
    
}

