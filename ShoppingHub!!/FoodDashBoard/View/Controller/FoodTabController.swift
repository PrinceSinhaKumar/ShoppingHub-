//
//  FoodTabController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import UIKit

class FoodTabController: UIViewController {
    
    var viewModel: FoodTabViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       viewModel = FoodTabViewModel(model: FoodTabModel())
        viewModel?.fetchMealsList(handler: { _, error in
            print(self.viewModel?.model?.mealList!)
        })
    }

}
