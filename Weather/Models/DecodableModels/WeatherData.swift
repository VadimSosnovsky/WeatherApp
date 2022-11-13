//
//  WeatherData.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit

struct WeatherData: Decodable {
    let info: Info
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case info
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
}
