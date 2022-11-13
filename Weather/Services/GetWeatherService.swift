//
//  GetWeatherService.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit
import CoreLocation

protocol WeatherProtocol {
    func getCityWeather(city: String, completion: @escaping (Weather?) -> Void)
    func getCoordinateFrom(city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ())
}

struct GetWeatherService: WeatherProtocol {
    
    static let shared = GetWeatherService()
    
    func getCityWeather(city: String, completion: @escaping (Weather?) -> Void) {
        getCoordinateFrom(city: city) { (coordinate, error) in
            
            if let _ = error {
                completion(nil)
            }
            
            guard let coordinate = coordinate else { return }
            
            NetworkWeatherManager.shared.fetchWeather(latitude: coordinate.latitude,
                                               longitude: coordinate.longitude) { (weather) in
                guard let weather = weather else { return }
                completion(weather)
            }
        }
    }

    func getCoordinateFrom(city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
