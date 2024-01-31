//
//  FoodTopOptionbarViewModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation

class FoodTopOptionbarViewModel {
    var menuList: [String]?
    
    func numberTabs() -> Int{
        guard let count = menuList?.count else { return 0 }
        return count
    }
    
    func getTitle(index: Int) -> String {
        return menuList?[index] ?? ""
    }
}
