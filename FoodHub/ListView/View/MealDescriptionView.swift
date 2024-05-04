//
//  MealDescriptionView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI

struct MealDescriptionView: View {
    @ObservedObject var meal: MealDataList
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                HStack {
                    Rectangle()
                        .fill(AppColor.AppOrange.swiftUIColor)
                        .frame(width: 5, height: 30)
                        .clipShape(.capsule)
                        .padding(.leading , 0)
                        .padding(.trailing, -1)
                    Text(meal.strCategory ?? "")
                        .font(AppFontSUI.fontSUI(with: 15, family: OpenSans.regular))
                        .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                }
                Spacer()
                HStack {
                    Button(action: {
                        //todo action
                    }, label: {
                        Image(systemName: "link.circle")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                    })
                    Button(action: {
                        //todo action
                    }, label: {
                        Image(systemName: "heart")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                    })
                }
                .padding(.trailing , -3)
            }
            Text(meal.strMeal ?? "")
                .font(AppFontSUI.fontSUI(with: 18, family: OpenSans.bold))
            HStack {
                Image(.cooking)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.leading , -8)
                Spacer()
                Image(.soupBowl)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 2)
                Text("9")
                    .font(AppFontSUI.fontSUI(with: 15, family: OpenSans.light))
                    .foregroundColor(AppColor.AppBlackTitle.swiftUIColor)
            }
            
        }
        .padding([.trailing, .leading])
    }
}

//#Preview {
//    MealDescriptionView()
//}

