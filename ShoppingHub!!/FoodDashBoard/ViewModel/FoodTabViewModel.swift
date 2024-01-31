//
//  FoodTabViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

class FoodTabViewModel {
    
    let model: FoodTabModel?
    
    init(model: FoodTabModel) {
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
    
    func getMeals() -> [Meals]? {
        return model?.fetchMealsFromDB()
    }
}
