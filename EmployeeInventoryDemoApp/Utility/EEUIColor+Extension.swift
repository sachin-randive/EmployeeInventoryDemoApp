//
//  OWUIColor+Extension.swift
//  OptusWeatherDemoApp
//
//  Created by Sachin Randive on 26/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let colorTop =  UIColor(red: 80.0/255.0, green: 106.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor
    static let colorBottom = UIColor(red:191.0/255.0, green: 163.0/255.0, blue:163.0/255.0, alpha: 1.0).cgColor
}

extension UIViewController {
    func setGradientBackground(gradientLayer: CAGradientLayer) {
        gradientLayer.colors = [UIColor.colorTop, UIColor.colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

