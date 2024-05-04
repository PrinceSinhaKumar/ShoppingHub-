//
//  MealView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 01/05/24.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var meal: MealDataList
    var body: some View {
        ZStack(alignment: .topLeading){
            HStack {
                MealDescriptionView(meal: meal)
                    .padding([.top, .bottom], 10)
                    .padding(.leading ,100)
                
            }
            .background(AppColor.AppWhiteSecond.swiftUIColor)
            .clipShape(.rect(cornerRadius: 20))
            .padding([.leading, .top, .bottom])
            MealImageView(imageURL: meal.strMealThumb ?? "")
                .padding(.top, -5)
                .shadow(color: AppColor.AppBlackTitle.swiftUIColor.opacity(0.5), radius: 10, x: 4, y: 10)
        }
        .background(Color.clear)
    }
}
