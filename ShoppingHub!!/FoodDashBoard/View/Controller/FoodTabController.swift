//
//  FoodTabController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import UIKit
import Swinject

class FoodTabController: UIViewController {
    private var viewModel: FoodTabViewModelDelegate?
    fileprivate var navigationCoordinator: NavigationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradient()
    }
 
    func configure(viewModel: FoodTabViewModelDelegate,
                   navigationCoordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.navigationCoordinator = navigationCoordinator
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sID = segue.identifier else { return }
        if sID == "FoodSegue" {
            if let tabVC = segue.destination as? FoodOptionTopBarController {
                guard let menuList = viewModel?.getTopMenuList() else { return }
                let dependencyRegistry: DependencyRegistry = appDelegate.dependencyRegistry

                let vModel = FoodTopOptionbarViewModel(menuList: menuList, meals: viewModel?.getMeals())
                tabVC.configure(viewModel: vModel, mealListTableViewControllerMaker: dependencyRegistry.makeMealListTableViewControllerMaker)
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
