//
//  MealSeachViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 05/02/24.
//

import Foundation

class MealSeachViewModel: ListViewModel {
    
    var list: [MealList]?
    var searchedData: [MealList]?
    
    init(list: [MealList]?) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int{
        return searchedData?.count ?? 0
    }
    
    func mealAtIndex(index: Int) -> MealList?{
        return searchedData?[index]
    }
    
    func searchedData(text: String) {
        searchedData = list?.filter({$0.strMeal?.lowercased().contains(text.lowercased()) ?? false})
        searchedData?.indices.forEach { searchedData?[$0].searchedText = text }
    }
}
