//
//  MealListViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import Foundation

protocol ListViewModel {
    associatedtype ValueType
    var list: [ValueType]? { get set }
    func numberOfRowsInSection() -> Int
    func valueAtIndex(index: Int) -> ValueType?
}

protocol ViewModelForMealList: ListViewModel {
    func getIndex(notification: Notification) -> (Int?, Bool?)
    func moveListItem(index: Int, insertAt: Int)
}

class MealListViewModel: ViewModelForMealList {
    
    typealias ValueType = MealList
    
    var list: [MealList]?
    
    init(list: [MealList]?) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int{
        return list?.count ?? 0
    }
    
    func valueAtIndex(index: Int) -> MealList?{
        return list?[index]
    }
    
    func getIndex(notification: Notification) -> (Int?, Bool?) {
        if let dict = notification.object as? [String: Any?], let id = dict[observerID] as? String, let isFavourite = dict[observerIsFavt] as? Bool {
            if let index = list?.firstIndex(where: {$0.idMeal == id}) {
                list?[index].isFavourite = isFavourite
                return (index, isFavourite)
            }
        }
        return (nil, nil)
    }
    
    func moveListItem(index: Int, insertAt: Int) {
        if let meal = valueAtIndex(index: index) {
            list?.remove(at: index)
            list?.insert(meal, at: insertAt)
        }
    }
}
