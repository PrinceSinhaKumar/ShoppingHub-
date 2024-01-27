//
//  AppGradientLayer.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 24/01/24.
//

import Foundation
import UIKit


extension UIView{
    
    func applyGradient(_ colorSet: [UIColor]? = [
        UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1),
        UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1)]){
            
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colorSet?.map{ $0.cgColor }
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

class GradientBackgroundView: UIView {
    
    var colorSet: [UIColor] = [
        UIColor(red: 87/255, green: 62/255, blue: 65/255, alpha: 1),
        UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1)
    ] {
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
