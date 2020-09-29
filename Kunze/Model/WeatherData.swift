//
//  WeatherData.swift
//  Kunze
//
//  Created by Kudzaishe Mhou on 2020/09/09.
//  Copyright © 2020 Kudakwashe Matigimu. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Double
}

struct Main: Codable {
    
    let temp: Double
}

struct Weather: Codable {
    let main: String
    let id: Int
}


