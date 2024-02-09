//
//  MealViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import UIKit
import Kingfisher

class MealViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var mealImageView: UIImageView!
    
    fileprivate var viewModel: MealDetailViewModel?
    fileprivate var mealDetailViewControllerMaker: DependencyRegistry.MealDetailViewControllerMaker?
    fileprivate var ingredientDataSource: IngredientDataSource?
    fileprivate var coordinator: NavigationCoordinator?
    
    func configure(viewModel: MealDetailViewModel,
                   mealDetailViewControllerMaker: @escaping DependencyRegistry.MealDetailViewControllerMaker,
                   ingredientDataSource: IngredientDataSource,
                   coordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.mealDetailViewControllerMaker = mealDetailViewControllerMaker
        self.ingredientDataSource = ingredientDataSource
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealImageView.kf.setImage(with: URL(string: viewModel?.getMeal().strMealThumb ?? ""))
        coordinator?.configureNavigationItems(for: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sID = segue.identifier else { return }
        if sID == "mealDetail" {
            if let mealDVC = segue.destination as? MealDetailViewController {
                mealDVC.configure(viewModel: viewModel!,
                                  ingredientDataSource: self.ingredientDataSource!)
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
