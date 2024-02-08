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
    private(set) var searchedData: [ValueType]?
    private(set) var selectedCategory: [CategoryModel] = []
    
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
        if selectedCategory.count > 0 {
            searchedData = searchedData?.filter({ meal in
                return selectedCategory.contains(where: {$0.categoryName == meal.strCategory })
            })
        }
        searchedData?.indices.forEach { searchedData?[$0].searchedText = text }
    }
    
    func getCategoryList() -> [CategoryModel]? {
        if let categorys = list?.map({CategoryModel(categoryName: $0.strCategory ?? "" , selectedStatus: false)}).unique() {
            return categorys.map { model in
                let newData = model
                if selectedCategory.contains(where: {$0.categoryName == model.categoryName }) {
                    newData.selectedStatus = true
                }
                return newData
            }
        }
        return nil
    }
   
    func filteredMealList(category: [String]) {
        searchedData = list?.filter { meal in
            guard let mealCategory = meal.strCategory else {
                return false
            }
            return category.contains(mealCategory)
        }
    }

    func saveSelectedCategory(selected categorys: [CategoryModel]) {
        guard selectedCategory.count > 0 else {
            selectedCategory.append(contentsOf: categorys)
            return
        }
        let newCategory = categorys.compactMap { category in
            if selectedCategory.contains(where: { $0.categoryName != category.categoryName }) {
                return category
            }
            return nil
        }
        selectedCategory.append(contentsOf: newCategory)
    }
}
