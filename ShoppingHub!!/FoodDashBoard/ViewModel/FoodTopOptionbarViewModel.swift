//
//  FoodTopOptionbarViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

class FoodTopOptionbarViewModel {
    var menuList: [String]?
    var meals: [Meals]?
    
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
