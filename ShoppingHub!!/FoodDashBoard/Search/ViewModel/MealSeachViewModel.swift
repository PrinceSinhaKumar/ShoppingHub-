//
//  MealSeachViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 05/02/24.
//

import Foundation

class MealSeachViewModel: ListViewModel {
    
    var list: [MealList]?
    
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
