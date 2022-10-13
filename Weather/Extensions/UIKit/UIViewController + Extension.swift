//
//  UIViewController + Extension.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit

extension UIViewController {
    func addCityAlertController(title: String, completion: @escaping(String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            let cities = ["San Francisco", "Moscow", "New-York", "Stambul", "Viena"]
            textField.placeholder = cities.randomElement()
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfttext = alert.textFields?.first
            guard let text = tfttext?.text else { return }
            GetWeatherService.shared.getCityWeather(city: text) { (weather) in
                guard let _ = weather else {
                    self.dismiss(animated: true, completion: nil)
                    alert.title = "Wrong city name"
                    alert.textFields?.first?.text = ""
                    self.present(alert, animated: true)
                    return
                }
            completion(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) in }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
