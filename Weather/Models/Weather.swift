//
//  Weather.swift
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit

struct Weather {
    var temperature: Int = 0
    var temperatureString: String {
        return String(temperature)
    }
    
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var presureMm: Int = 0
    var windSpeed: Double = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    let hours: [Hour]
    let forecasts: [Forecast]
    let cityName: String
    let offset: Int
    
    var conditionString: String {
        switch condition {
        case "clear": return "Ясно"
        case "partly-cloudy": return "Малооблачно"
        case "cloudy": return "Облачно с прояснениями"
        case "overcast": return "Пасмурно"
        case "drizzle": return "Морось"
        case "light-rain": return "Небольшой дождь"
        case "rain": return "Дождь"
        case "moderate-rain": return "Умеренно сильный дождь"
        case "heavy-rain": return "Сильный дождь"
        case "continious-heavy-rain": return "Длительный сильный дождь"
        case "showers": return "Ливень"
        case "wet-snow": return "Дождь со снегом"
        case "light-snow": return "Небольшой снег"
        case "snow": return "Снег"
        case "snow-showers": return "Снегопад"
        case "nail": return "Град"
        case "thunderstorm": return "Гроза"
        case "thunderstorm-with-rain": return "Дождь с грозой"
        case "thunderstorm-with-hail": return "Дождь с градом"
        default:
            return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        presureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        
        guard let firstItem = weatherData.forecasts.first else { return nil }
        
        if let tempMin = firstItem.parts.day.tempMin {
            self.tempMin = tempMin
        }
        
        if let tempMax = firstItem.parts.day.tempMax {
            self.tempMax = tempMax
        }

        hours = firstItem.hours
        cityName = weatherData.geoObject.locality.name
        forecasts = weatherData.forecasts
        offset = weatherData.info.tzinfo.offset
    }
}
