//
//  MealFilterViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import UIKit

class MealFilterViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var mealFilterDataSource: MealFilterDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        mealFilterDataSource = MealFilterDataSource()
        tableView.dataSource = mealFilterDataSource
        self.tableView.contentInsetAdjustmentBehavior = .never

        // Do any additional setup after loading the view.
    }

}


