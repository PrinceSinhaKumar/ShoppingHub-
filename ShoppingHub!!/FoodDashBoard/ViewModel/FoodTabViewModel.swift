//
//  FoodTabViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

class FoodTabViewModel {
    
    let model: FoodTabModel?
    var topMenuList: [String]? = []
    
    init(model: FoodTabModel) {
        self.model = model
    }
    
    func fetchMealsList(handler: @escaping Handler){
        model?.fetchFoodList("c") { [weak self] mealList, error in
            self?.getTopMenuList()
            handler(mealList, error)
        }
    }
    
    fileprivate func getTopMenuList(){
        if let meals = model?.mealList {
            topMenuList?.append(contentsOf: meals.map({$0.strArea ?? ""}))
            topMenuList = topMenuList?.unique()
        }
    }
}
