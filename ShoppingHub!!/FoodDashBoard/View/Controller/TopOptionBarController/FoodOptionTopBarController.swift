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
    fileprivate var viewModel: FoodTopOptionbarViewModelDelegate!
    fileprivate var mealListTableViewControllerMaker: DependencyRegistry.MealListTableViewControllerMaker!
    
    func configure(viewModel: FoodTopOptionbarViewModelDelegate,
                   mealListTableViewControllerMaker: @escaping DependencyRegistry.MealListTableViewControllerMaker) {
        self.viewModel = viewModel
        self.mealListTableViewControllerMaker = mealListTableViewControllerMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create bar
        let topOptionBar = TopOptionBar(viewModel: viewModel, controller: getControllers())
        self.dataSource = topOptionBar
        topOptionBar.delegate = self
        // Add to view
        addBar(topOptionBar, dataSource: topOptionBar, at: .top)
    }
    
    fileprivate func getControllers() -> [UIViewController] {
        var controllers: [UIViewController] = []
        viewModel.menuList?.forEach({ title in
            let mealVC = mealListTableViewControllerMaker(viewModel.getMealsAccToArea(area: title)!)
            controllers.append(mealVC)
        })
        return controllers
    }
}
