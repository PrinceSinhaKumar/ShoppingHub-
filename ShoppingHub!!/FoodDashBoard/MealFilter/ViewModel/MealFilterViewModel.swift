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
    var selectedCategory: [CategoryModel] = []
    
    init(list: [CategoryModel]) {
        self.list = list
        self.selectedCategory = list.filter({$0.selectedStatus})
    }
    
    func numberOfRowsInSection() -> Int {
        list?.count ?? 0
    }
    
    func valueAtIndex(index: Int) -> ValueType? {
        list?[index]
    }
    
    func saveSelectedCategory(_ category: CategoryModel){
        selectedCategory.append(category)
    }
    
    func removeSelectedCategory(_ category: CategoryModel){
        if let index = selectedCategory.firstIndex(where: {$0.categoryName == category.categoryName}) {
            selectedCategory.remove(at: index)
        }
    }

}

//CategoryModel
class CategoryModel: Hashable {
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.categoryName == rhs.categoryName
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryName)
    }
    
    var categoryName: String
    var selectedStatus: Bool = false
    
    init(categoryName: String, selectedStatus: Bool) {
        self.categoryName = categoryName
        self.selectedStatus = selectedStatus
    }
}
