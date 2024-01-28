//
//  FoodTabModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import Foundation

class FoodTabModel {
    
    var foodList: FoodListDecodableModel?
    
    func fetchFoodList(_ keyword:String){
        ApiManager.shared.getData(from: .getFoodList(keyword)) { [weak self] result, error in
            self?.foodList = result
        }
    }
    
}
