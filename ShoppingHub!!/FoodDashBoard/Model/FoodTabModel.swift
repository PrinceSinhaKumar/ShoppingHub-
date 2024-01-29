//
//  FoodTabModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import Foundation

class FoodTabModel {

    var mealList: [Meals]?
        
    func fetchFoodList(_ keyword:String, handler: @escaping Handler){
        ApiManager.shared.getData(from: .getFoodList(keyword)) {[weak self] meals, error in
            MealDataManager.shared.saveMeals(mealData: meals)
            self?.fetchMealsFromDB()
            handler(meals, error)
        }
    }
    
    fileprivate func fetchMealsFromDB(){
        let list = MealDataProvider.shared.fetchMeals()
        let meals: [Meals] = list.map({.init(meal: $0)})
        mealList = meals
    }
    
}
