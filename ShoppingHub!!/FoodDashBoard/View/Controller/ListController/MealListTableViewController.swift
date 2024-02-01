//
//  MealListTableViewController.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import UIKit

class MealListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MealListViewModel?
    var mealListDataSource: MealListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // cell register
        mealListDataSource = MealListDataSource(cellIdentifier: "MenuListTableViewCell", viewModel: viewModel!, tableview: tableView)
        tableView.dataSource = mealListDataSource
    }

}
