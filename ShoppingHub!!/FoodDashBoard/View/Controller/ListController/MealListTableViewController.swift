//
//  MealListTableViewController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import UIKit

class MealListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel: MealListViewModel?
    fileprivate var mealListDataSource: MealListDataSource!
    
    func configure(viewModel: MealListViewModel, mealListDataSource: MealListDataSource ) {
        self.viewModel = viewModel
        self.mealListDataSource = mealListDataSource
        let dependencyRegistry: DependencyRegistry = AppDelegate.dependencyRegistry
        self.mealListDataSource.configure(makeMealCell: dependencyRegistry.makeMealCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = mealListDataSource
    }

}
