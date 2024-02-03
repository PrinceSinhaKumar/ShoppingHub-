//
//  FoodTabViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

protocol FoodTabViewModelDelegate {
    var model: FoodTabModelDelegate? {get}

    func getTopMenuList() -> [String]
    func getMeals() -> [MealList]?
}

class FoodTabViewModel: FoodTabViewModelDelegate {
    
    let model: FoodTabModelDelegate?
    
    init(model: FoodTabModelDelegate) {
        self.model = model
    }
    
    func getTopMenuList() -> [String]{
        var topMenuList: [String] = ["All"]
        if let meals = getMeals() {
            topMenuList.append(contentsOf: meals.map({$0.strArea ?? ""}))
            topMenuList = topMenuList.unique().sorted{ $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
        }
        return topMenuList
    }
    
    func getMeals() -> [MealList]? {
        return model?.fetchMealsFromDB()
    }
}
