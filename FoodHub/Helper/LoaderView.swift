//
//  LoaderView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color(.black)
                .blur(radius: 0)
                .opacity(0.4)
                .ignoresSafeArea()
            ProgressView(label: {
                Text("Loading")
                    .font(AppFontSUI.fontSUI(with: 6, family: OpenSans.medium))
                    .foregroundStyle(.white)
            })
                .progressViewStyle(.circular).tint(.white)
                .scaleEffect(2.5)
        }
    }
}

#Preview {
    LoaderView()
}
