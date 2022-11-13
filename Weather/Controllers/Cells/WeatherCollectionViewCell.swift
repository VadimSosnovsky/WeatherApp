//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit
import SDWebImage

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "WeatherCollectionViewCell"
    
    private let hourLabel = UILabel(font: .helveticaNeueLight22(), textColor: .mainWhite())
    private let tempLabel = UILabel(font: .helveticaNeueLight22(), textColor: .mainWhite())
    
    private let weatherImageView = UIImageView(image: UIImage(named: "nil"), contentMode: .scaleAspectFit)
    
    private var containerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        customizeElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension WeatherCollectionViewCell {
    func configure(cell: Hour) {
        
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(cell.icon).svg")
        else { return }
        weatherImageView.sd_setImage(with: url)
        
        guard let hour = cell.hour else { return }
        guard let temp = cell.temp else { return }
        
        hourLabel.text = "\(hour)"
        tempLabel.text = "\(temp)º"
    }
}

// MARK: - Setup Views
extension WeatherCollectionViewCell {
    
    private func setupViews() {
        containerStackView = UIStackView(arrangedSubviews: [hourLabel,
                                                            weatherImageView,
                                                            tempLabel],
                                         axis: .vertical,
                                         spacing: 10,
                                         distribution: .fillEqually,
                                         alignment: .center)
        
        self.addSubview(containerStackView)
    }
    
    func customizeElements() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints
extension WeatherCollectionViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
