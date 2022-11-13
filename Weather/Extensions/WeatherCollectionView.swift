//
//  WeatherCollectionView.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit

class WeatherCollectionView: UICollectionView {
    
    var cells = [Hour]()
    var offset: Int?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        backgroundColor = .darkBlue()
        delegate = self
        dataSource = self
        register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set cells
extension WeatherCollectionView {
    func set(cells: [Hour], offset: Int) {
        self.offset = offset
        
        let timeHere = Date()
        let customDateFormatter = DateFormatter()
        customDateFormatter.dateFormat = "HH"
        customDateFormatter.calendar = .current
        customDateFormatter.timeZone = TimeZone(secondsFromGMT: offset)
        let timeThere = customDateFormatter.string(from: timeHere)
        
        self.cells = cells.filter({
            guard let hour = $0.hour,
                  let convertedHour = Int(hour),
                  let convertedTime = Int(timeThere)
            else { return false }
            return convertedHour >= convertedTime
        })
    }
}

extension WeatherCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        let weather = cells[indexPath.row]
        cell.configure(cell: weather)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
}
