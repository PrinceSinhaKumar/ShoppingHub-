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
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = mealListDataSource
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCell(notification:)), name: NSNotification.Name.init(reloadMealCell), object: nil)
    }
    
    @objc fileprivate func reloadCell(notification: Notification) {
        if let tupleValue = viewModel?.getIndex(notification: notification),
           let index = tupleValue.0,
           let isFavourite = tupleValue.1 {
            DispatchQueue.main.async { [weak self] in
                if isFavourite {
                    self?.moveCellToTop(at: index)
                } else {
                    self?.moveCellToBottom(at: index)
                }
            }
        }
    }

    private func moveCellToTop(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        viewModel?.moveListItem(index: index, insertAt: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

    private func moveCellToBottom(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        let lastPosition = (viewModel?.numberOfRowsInSection() ?? 0) - 1
        viewModel?.moveListItem(index: index, insertAt: lastPosition)
        tableView.insertRows(at: [IndexPath(row: lastPosition, section: 0)], with: .automatic)
        tableView.endUpdates()
    }


}
extension MealListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.next(navState: .mealDetail, arguments: [argumentsKey: viewModel?.mealAtIndex(index: indexPath.row) as Any])
    }
    
}
