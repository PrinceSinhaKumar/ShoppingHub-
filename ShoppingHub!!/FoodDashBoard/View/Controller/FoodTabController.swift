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
        applyGradient()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sID = segue.identifier else { return }
        if sID == "FoodSegue" {
            if let tabVC = segue.destination as? FoodOptionTopBarController {
                guard let menuList = viewModel?.getTopMenuList() else { return }
                tabVC.viewModel.menuList = menuList
                tabVC.viewModel.meals = viewModel?.getMeals()
            }
        }
    }
    
    fileprivate func applyGradient() {
        let myGradientView = GradientBackgroundView(frame: view.bounds)
        view.insertSubview(myGradientView, at: 0)
        // dynamically updating the color set
        myGradientView.colorSet = [AppColor.AppOrange.color!, AppColor.AppWhiteSecond.color!]
    }
   
}
