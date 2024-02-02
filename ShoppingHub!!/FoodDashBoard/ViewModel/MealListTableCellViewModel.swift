//
//  MealListTableCellViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 01/02/24.
//

import Foundation

struct MealCellViewModel {
    let strMeal: String
    let strCategory: String
    let mealImageURL: URL?

    init(meal: Meals) {
        self.strMeal = meal.strMeal ?? ""
        self.strCategory = meal.strCategory ?? ""
        self.mealImageURL = URL(string: meal.strMealThumb ?? "")
    }
}
