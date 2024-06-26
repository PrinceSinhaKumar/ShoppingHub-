//
//  SwiftUIView.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

struct GradientView: View {
    var gradientColor: [UIColor]?
    var body: some View {
        ZStack {
            if let colors = gradientColor {
                GradientBackgroundView(colorSet: colors)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
