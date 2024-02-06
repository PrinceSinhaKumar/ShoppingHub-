//
//  MealFilterViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import Foundation

class MealFilterViewModel {
    
    var list: [MealList]?
    var selectedCategory: Set<String> = []
    
    init(list: [MealList]?) {
        self.list = list
    }
    
    func getCategoryList() -> [String]?{
        self.list?.map({$0.strCategory ?? ""}).unique()
    }
    func getCategoryCount() -> Int {
        return getCategoryList()?.count ?? 0
    }
   
    func getCategoryAtIndex(index: Int) -> String? {
        return getCategoryList()?[index]
    }
    
    func saveSelectedCategory(_ category: String){
        selectedCategory.insert(category)
    }
    
    func removeSelectedCategory(_ category: String){
        selectedCategory.remove(category)
    }
}
