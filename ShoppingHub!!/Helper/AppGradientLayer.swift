//
//  AppGradientLayer.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 24/01/24.
//

import Foundation
import UIKit

class GradientBackgroundUIView: UIView {
    
    var colorSet: [UIColor] = [] {
        didSet {
            updateGradient()
        }
    }

    private func updateGradient() {
        // Remove existing gradient layers
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        // Create a new gradient layer with the updated color set
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colorSet.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        // Add the new gradient layer as the background
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func draw(_ rect: CGRect) {
        updateGradient()
    }
   
}
