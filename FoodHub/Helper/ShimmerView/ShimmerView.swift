//
//  ShimmerView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI

struct ShimmerView: View {
    
    @State var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    let gradientColor = [AppColor.AppOrange.swiftUIColor.opacity(0.2), Color.white.opacity(0.2), AppColor.AppOrange.swiftUIColor.opacity(0.2)]

    var body: some View {
        LinearGradient(colors: gradientColor, startPoint: startPoint, endPoint: endPoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }
    }
}

#Preview {
    ShimmerView()
}
