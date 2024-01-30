//
//  FoodTabController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import UIKit

class FoodTabController: UIViewController {
    
    var viewModel: FoodTabViewModel?
    var foodTopOptionBar: FoodOptionTopBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialSetup()
    }
    
//    fileprivate func initialSetup(){
//        viewModel = FoodTabViewModel(model: FoodTabModel())
//        viewModel?.fetchMealsList(handler: { _, error in
//
//        })
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sID = segue.identifier else { return }
        if sID == "FoodSegue" {
            if let tabVC = segue.destination as? FoodOptionTopBarController {
                foodTopOptionBar = tabVC
                guard let menuList = viewModel?.topMenuList else { return }
                tabVC.viewModel.menuList = menuList
                tabVC.navController = self.navigationController
            }
        }
    }
}
