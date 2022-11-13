//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit
import SDWebImage

class WeatherTableViewCell: UITableViewCell {
    
    static let reuseId = "WeatherTableViewCell"
    
    private let dayLabel = UILabel(font: .helveticaNeueLight22(), textColor: .mainWhite())
    private let weatherImageView = UIImageView(image: UIImage(named: "nil"), contentMode: .scaleAspectFit)
    private let dayTempLabel = UILabel(font: .helveticaNeueLight22(), textColor: .mainWhite())
    private let nightTempLabel = UILabel(font: .helveticaNeueLight22(), textColor: .mainWhite())
    
    private var rightStackView = UIStackView()
    
    private var day: Int = 0
    
    private var dayOfWeek: String {
        switch day {
        case 1:
            return "Воскресенье"
        case 2:
            return "Понедельник"
        case 3:
            return "Вторник"
        case 4:
            return "Среда"
        case 5:
            return "Четверг"
        case 6:
            return "Пятница"
        case 7:
            return "Суббота"
        default:
            return "Unknown"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        customizeElements()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        dayTempLabel.textAlignment = .right
        nightTempLabel.textAlignment = .right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension WeatherTableViewCell {
    func configure(weather: Forecast) {
        
        let customDateFormatter = DateFormatter()
        customDateFormatter.dateFormat = "yyyy-MM-dd"
        customDateFormatter.calendar = .current
        guard let date = customDateFormatter.date(from: weather.date) else { return }
        let calendar = Calendar.current
        day = calendar.component(.weekday, from: date)
        
        dayLabel.text = "\(dayOfWeek)"
       
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weather.parts.day.icon).svg")
        else { return }
        weatherImageView.sd_setImage(with: url)
        
        guard let dayTempAverage = weather.parts.day.tempAvg else { return }
        guard let nightTempAverage = weather.parts.night.tempAvg else { return }
        
        dayTempLabel.text = "\(dayTempAverage)"
        nightTempLabel.text = "\(nightTempAverage)"
    }
}

// MARK: - Setup Views
extension WeatherTableViewCell {
    private func setupViews() {
        
        rightStackView = UIStackView(arrangedSubviews: [dayTempLabel,
                                                        nightTempLabel],
                                     axis: .horizontal,
                                     spacing: 20,
                                     distribution: .fillEqually,
                                     alignment: .fill)
        
        self.addSubview(dayLabel)
        self.addSubview(weatherImageView)
        self.addSubview(rightStackView)
    }
    
    func customizeElements() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints
extension WeatherTableViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dayLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            weatherImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            rightStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightStackView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
