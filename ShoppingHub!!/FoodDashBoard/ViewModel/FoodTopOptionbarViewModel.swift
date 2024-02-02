//
//  FoodTopOptionbarViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

protocol FoodTopOptionbarViewModelDelegate {
    var menuList: [String]? { get }
    var meals: [Meals]? { get }
    
    func numberTabs() -> Int
    func getTitle(index: Int) -> String
    func getMealsAccToArea(area: String) -> [Meals]?
}

class FoodTopOptionbarViewModel: FoodTopOptionbarViewModelDelegate {
    let menuList: [String]?
    let meals: [Meals]?
    
    init(menuList: [String]?, meals: [Meals]?) {
        self.menuList = menuList
        self.meals = meals
    }
    
    func numberTabs() -> Int{
        guard let count = menuList?.count else { return 0 }
        return count
    }
    
    func getTitle(index: Int) -> String {
        return menuList?[index] ?? ""
    }
    
    func getMealsAccToArea(area: String) -> [Meals]?{
        guard area != "All" else {
            return meals
        }
        return meals?.filter({$0.strArea == area})
    }
}
