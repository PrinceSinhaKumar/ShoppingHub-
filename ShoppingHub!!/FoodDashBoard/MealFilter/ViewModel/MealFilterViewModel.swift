//
//  MealFilterViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import Foundation

class MealFilterViewModel: ListViewModel {

    typealias ValueType = CategoryModel
    var list: [CategoryModel]?
    var selectedCategory: Set<String> = []
    
    init(list: [CategoryModel]) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int {
        list?.count ?? 0
    }
    
    func valueAtIndex(index: Int) -> ValueType? {
        list?[index]
    }
    
    func saveSelectedCategory(_ category: String){
        selectedCategory.insert(category)
    }
    
    func removeSelectedCategory(_ category: String){
        selectedCategory.remove(category)
    }
    
    func getSelectedCategory() -> [String]{
       return Array(selectedCategory)
    }
}

//CategoryModel
class CategoryModel {
    
    var categoryName: String
    var selectedStatus: Bool = false
    
    init(categoryName: String, selectedStatus: Bool) {
        self.categoryName = categoryName
        self.selectedStatus = selectedStatus
    }
}
