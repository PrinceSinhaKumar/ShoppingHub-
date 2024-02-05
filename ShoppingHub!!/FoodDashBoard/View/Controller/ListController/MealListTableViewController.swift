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
    fileprivate var coordinator: NavigationCoordinator!
    
    func configure(viewModel: MealListViewModel, mealListDataSource: MealListDataSource, coordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.mealListDataSource = mealListDataSource
        let dependencyRegistry: DependencyRegistry = appDelegate.dependencyRegistry
        self.mealListDataSource.configure(makeMealCell: dependencyRegistry.makeMealCell)
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = mealListDataSource
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell(notification:)), name: NSNotification.Name.init(reloadMealCell), object: nil)
    }
    
    @objc fileprivate func reloadCell(notification: Notification) {
        if let index = viewModel?.getIndex(notification: notification) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadRows(at: [IndexPath.SubSequence(row: index, section: 0)], with: .automatic)
            }
        }
    }

}
extension MealListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.next(navState: .mealDetail, arguments: [argumentsKey: viewModel?.mealAtIndex(index: indexPath.row) as Any])
    }
    
}
