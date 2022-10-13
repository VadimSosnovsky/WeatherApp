//
//  PageVC.swift
//  PageControllerTutorial
//
//  Created by Chris Larsen on 5/30/19.
//  Copyright © 2019 Tiger Bomb. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    private let cityNameLabel = UILabel(font: .helveticaNeueLight30(), textColor: .mainWhite())
    private let weatherLabel = UILabel(font: .helveticaNeueLight26(), textColor: .mainWhite())
    private let tempLabel = UILabel(font: .helveticaNeueLight30(), textColor: .mainWhite())
    private let maxAndMinTempLabel = UILabel(font: .helveticaNeueLight26(), textColor: .mainWhite())
    
    private var activityIndicator: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
       loader.hidesWhenStopped = true
       loader.style = .large
       loader.color = .mainWhite()
       return loader
    }()
    
    private var containerStackView = UIStackView()
    
    private let weatherCollectionView = WeatherCollectionView()
    private let weatherTableView = WeatherTableView()
    
    var index: Int
    private var city: String
    
    init(with city: String, index: Int) {
        self.city = city
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBlue()

        getCityWeather()
        
        hideViews()
        setupViews()
        customizeElements()
        setupConstraints()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - Setup Views
extension PageViewController {
    private func setupViews() {
        containerStackView = UIStackView(arrangedSubviews: [cityNameLabel,
                                                            weatherLabel,
                                                            tempLabel,
                                                            maxAndMinTempLabel],
                                         axis: .vertical,
                                         spacing: 10,
                                         distribution: .fill,
                                         alignment: .center)

        view.addSubview(containerStackView)
        view.addSubview(weatherCollectionView)
        view.addSubview(weatherTableView)
        view.addSubview(activityIndicator)
    }
    
    private func customizeElements() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configure(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            self?.cityNameLabel.text = weather.cityName
            self?.weatherLabel.text = weather.conditionString
            self?.tempLabel.text = "\(weather.temperatureString)º"
            self?.maxAndMinTempLabel.text = "Макс. \(weather.tempMax)º, мин. \(weather.tempMin)º"
        }
    }
    
    private func showViews() {
        containerStackView.isHidden = false
        weatherCollectionView.isHidden = false
        weatherTableView.isHidden = false
    }
    
    private func hideViews() {
        containerStackView.isHidden = true
        weatherCollectionView.isHidden = true
        weatherTableView.isHidden = true
    }
    
    private func getCityWeather() {
        GetWeatherService.shared.getCityWeather(city: city) { [weak self] (weather) in
            guard let weather = weather else { return }
            self?.weatherCollectionView.set(cells: weather.hours, offset: weather.offset)
            self?.weatherTableView.set(cells: weather.forecasts)
            self?.configure(weather: weather)
            DispatchQueue.main.async {
                self?.weatherCollectionView.reloadData()
                self?.weatherTableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.showViews()
            }
        }
    }
}

// MARK: - Setup Constraints
extension PageViewController {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 84),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 110)
        ])

        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 10),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
