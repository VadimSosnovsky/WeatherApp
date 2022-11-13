//
//  Hour.swift
//  Weather
//
//  Created by Вадим Сосновский on 20.10.2022.
//

import UIKit

struct Hour: Decodable {
    
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
