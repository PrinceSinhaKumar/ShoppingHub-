//
//  GradientBackgroundView.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

struct GradientBackgroundView: UIViewRepresentable {
    
    var colorSet: [UIColor]
    
    func makeUIView(context: Context) -> GradientBackgroundUIView {
        let gradientView = GradientBackgroundUIView()
        gradientView.colorSet = colorSet
        return gradientView
    }
    
    func updateUIView(_ uiView: GradientBackgroundUIView, context: Context) {
        uiView.colorSet = colorSet
    }
}
