//
//  Forecast.swift
//  Weather
//
//  Created by Вадим Сосновский on 20.10.2022.
//

import UIKit

struct Forecast: Decodable {
    let date: String
    let parts: Parts
    let hours: [Hour]
}
