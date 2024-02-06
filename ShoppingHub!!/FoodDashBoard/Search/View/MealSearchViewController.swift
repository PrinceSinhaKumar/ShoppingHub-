//
//  MealSearchViewController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 05/02/24.
//

import UIKit

class MealSearchViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    fileprivate var viewModel: MealSeachViewModel!
    fileprivate var coordinator: NavigationCoordinator!
    fileprivate var mealListDataSource: MealListDataSource!

    func configure(viewModel: MealSeachViewModel,
                   coordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.mealListDataSource = MealListDataSource(viewModel: viewModel, makeMealCell: appDelegate.dependencyRegistry.makeMealCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.configureNavigationItems(for: self)
        tableView.dataSource = mealListDataSource
    }
}
extension MealSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.next(navState: .mealDetail, arguments: [argumentsKey: viewModel?.mealAtIndex(index: indexPath.row) as Any])
    }
    
}
