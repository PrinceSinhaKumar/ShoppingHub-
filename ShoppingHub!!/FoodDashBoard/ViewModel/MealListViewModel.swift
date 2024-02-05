//
//  MealListViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import Foundation

class MealListViewModel {
    
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
    
    func getIndex(notification: Notification) -> (Int?) {
        if let dict = notification.object as? [String: Any?], let id = dict[observerID] as? String, let isFavourite = dict[observerIsFavt] as? Bool {
            if let index = list?.firstIndex(where: {$0.idMeal == id}) {
                list?[index].isFavourite = isFavourite
                return (index)
            }
        }
        return (nil)
    }
}
