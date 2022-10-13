//
//  WeatherData.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit

struct WeatherData: Codable {
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

struct Info: Codable {
    let url: String
    let tzinfo: Tzinfo
}

struct Tzinfo: Codable {
    let offset: Int
}

struct Fact: Codable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecast: Codable {
    let date: String
    let parts: Parts
    let hours: [Hour]
}

struct Parts: Codable {
    let day: Hour
    let night: Hour
}

struct GeoObject: Codable {
    let locality: Country
}

struct Country: Codable {
    let id: Int
    let name: String
}

struct Hour: Codable {
    
    let icon: String
    let hour: String?
    let temp: Int?
    let tempMin: Int?
    let tempMax: Int?
    let tempAvg: Int?

    enum CodingKeys: String, CodingKey {
        case icon
        case hour
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
    }
}
