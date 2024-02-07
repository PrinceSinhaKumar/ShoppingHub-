//
//  MealSeachViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 05/02/24.
//

import Foundation

class MealSeachViewModel: ListViewModel {
    typealias ValueType = MealList
    var list: [ValueType]?
    var searchedData: [ValueType]?
    
    init(list: [ValueType]?) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int{
        return searchedData?.count ?? 0
    }
    
    func valueAtIndex(index: Int) -> ValueType?{
        return searchedData?[index]
    }
    
    func searchedData(text: String) {
        searchedData = list?.filter({$0.strMeal?.lowercased().contains(text.lowercased()) ?? false})
        searchedData?.indices.forEach { searchedData?[$0].searchedText = text }
    }
    
    func getCategoryList() -> [String]? {
        return list?.map({$0.strCategory ?? ""}).unique()
    }
}
