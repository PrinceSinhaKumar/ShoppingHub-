//
//  MealFilterViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import UIKit

protocol GetCategoryListDelegate {
    func getCategoryList(category: [CategoryModel])
}

class MealFilterViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel: MealFilterViewModel!
    fileprivate var mealFilterDataSource: MealFilterDataSource!
    fileprivate var coordinator: NavigationCoordinator!
    var delegate: GetCategoryListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = mealFilterDataSource
        tableView.delegate = self
    }
    
    func configure(viewModel: MealFilterViewModel,
                   coordinator: NavigationCoordinator){
        self.viewModel = viewModel
        mealFilterDataSource = MealFilterDataSource(viewModel: viewModel, makeMealFilterCell: appDelegate.dependencyRegistry.makeMealFilterCellMaker)
        self.coordinator = coordinator
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        coordinator.movingBack(navState: .mealFilter, arguments: nil)
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        let dict:Dictionary<String, Any> = [argumentsKey: []]
        coordinator.movingBack(navState: .mealFilter, arguments: dict)
    }
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        let dict:Dictionary<String, Any> = [argumentsKey: self.viewModel.selectedCategory]
        coordinator.movingBack(navState: .mealFilter, arguments: dict)
    }
}

extension MealFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MealFilterTableViewCell {
            if viewModel.valueAtIndex(index: indexPath.row)?.selectedStatus ?? false {
                cell.categorySelection(status: false)
                viewModel.removeSelectedCategory(viewModel.valueAtIndex(index: indexPath.row)!)
            } else {
                cell.categorySelection(status: true)
                viewModel.saveSelectedCategory(viewModel.valueAtIndex(index: indexPath.row)!)
            }
            
        }
    }
    
}

