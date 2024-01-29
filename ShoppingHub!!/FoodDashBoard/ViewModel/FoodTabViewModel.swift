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
    
    func fetchMealsList(handler: @escaping Handler){
        model?.fetchFoodList("c", handler: handler)
    }
}
