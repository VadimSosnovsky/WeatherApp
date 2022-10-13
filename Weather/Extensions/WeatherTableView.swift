//
//  WeatherTableView.swift
//  Weather
//
//  Created by Вадим Сосновский on 26.09.2022.
//

import UIKit

class WeatherTableView: UITableView {
    
    var cells = [Forecast]()
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .darkBlue()
        delegate = self
        delegate = self
        dataSource = self
        register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        separatorStyle = .none
        isScrollEnabled = false
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set cells
extension WeatherTableView {
    func set(cells: [Forecast]) {
        self.cells = cells
    }
}

extension WeatherTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        let weather = cells[indexPath.row]
        cell.configure(weather: weather)
        
        return cell
    }
}
