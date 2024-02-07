//
//  MealFilterViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import Foundation

class MealFilterViewModel: ListViewModel {

    typealias ValueType = String
    var list: [String]?
    var selectedCategory: Set<String> = []
    
    init(list: [String]?) {
        self.list = list
    }
    
    func numberOfRowsInSection() -> Int {
        list?.count ?? 0
    }
    
    func valueAtIndex(index: Int) -> String? {
        list?[index]
    }
    
    func saveSelectedCategory(_ category: String){
        selectedCategory.insert(category)
    }
    
    func removeSelectedCategory(_ category: String){
        selectedCategory.remove(category)
    }
}
