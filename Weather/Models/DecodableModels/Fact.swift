//
//  Fact.swift
//  Weather
//
//  Created by Вадим Сосновский on 20.10.2022.
//

import UIKit

struct Fact: Decodable {
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
