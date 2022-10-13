//
//  UIImageView + Extension.swift
//  Weather
//
//  Created by Вадим Сосновский on 26.09.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}
