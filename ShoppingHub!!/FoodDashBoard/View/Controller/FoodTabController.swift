//
//  FoodTabController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import UIKit

class FoodTabController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
    }

    func fetchList(){
         FoodTabModel().fetchFoodList("r")
    }
}
