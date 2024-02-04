//
//  MealListViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import Foundation

class MealListViewModel {
    
    let list: [MealList]?
    
    init(list: [MealList]?) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int{
        return list?.count ?? 0
    }
    
    func mealAtIndex(index: Int) -> MealList?{
        return list?[index]
    }
    
}
