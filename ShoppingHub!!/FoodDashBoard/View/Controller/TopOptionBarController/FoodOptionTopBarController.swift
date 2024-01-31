//
//  FoodOptionTopBarController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import UIKit
import Pageboy
import Tabman

class FoodOptionTopBarController: TabmanViewController {
    
    //MARK: - Properties
    var viewModel = FoodTopOptionbarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create bar
        let topOptionBar = TopOptionBar(viewModel: viewModel, controller: getControllers())
        self.dataSource = topOptionBar
        // Add to view
        addBar(topOptionBar, dataSource: topOptionBar, at: .top)
    }
    
    fileprivate func getControllers() -> [UIViewController] {
        var controllers: [UIViewController] = []
        viewModel.menuList?.forEach({ title in
            let mealVC = MealListTableViewController()
            mealVC.viewModel = MealListViewModel(list: viewModel.getMealsAccToArea(area: title))
            controllers.append(mealVC)
        })
        return controllers
    }
}
