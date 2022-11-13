//
//  Info.swift
//  Weather
//
//  Created by Вадим Сосновский on 20.10.2022.
//

import UIKit

struct Info: Decodable {
    let url: String
    let tzinfo: Tzinfo
}
