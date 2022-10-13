//
//  UILabel + Extension.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont?, textColor: UIColor) {
        self.init()

        self.font = font
        self.textColor = textColor
    }
}
