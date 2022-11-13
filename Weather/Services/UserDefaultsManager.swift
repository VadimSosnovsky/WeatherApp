//
//  UserDefaultsManager.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    let defaults = UserDefaults.standard
    
    var cities: [String]? {
        get {
            return defaults.array(forKey: userkey) as? [String]
        }
        set {
            defaults.set(newValue, forKey: userkey)
        }
    }
}
