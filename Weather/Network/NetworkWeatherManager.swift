//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Вадим Сосновский on 23.09.2022.
//

import UIKit
import Alamofire
import CoreLocation

protocol NetworkWeatherProtocol {
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Weather?) -> Void)
}

struct NetworkWeatherManager: NetworkWeatherProtocol {
    
    static let shared = NetworkWeatherManager()
    
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Weather?) -> Void) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast"
        let parameters = ["lat": latitude,
                          "lon": longitude]
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": apiKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requestion data: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
        
            guard let data = dataResponse.data else { return }
        
            let decoder = JSONDecoder()
            do {
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                let weather = Weather(weatherData: weatherData)
                completionHandler(weather)
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completionHandler(nil)
            }
        }
    }
}
