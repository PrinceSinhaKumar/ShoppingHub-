//
//  FoodTabModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import Foundation

protocol FoodTabModelDelegate {
    func fetchMealsFromDB() -> [Meals]
}

class FoodTabModel: FoodTabModelDelegate {
    func fetchMealsFromDB() -> [Meals]{
        let list = MealDataProvider.shared.fetchMeals()
        return list.map({.init(meal: $0)})
    }
}
