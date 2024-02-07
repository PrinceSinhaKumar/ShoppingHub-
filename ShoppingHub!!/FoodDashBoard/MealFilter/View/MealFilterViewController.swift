//
//  MealFilterViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import UIKit

protocol GetCategoryListDelegate {
    func getCategoryList(category: [String])
}

class MealFilterViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel: MealFilterViewModel!
    fileprivate var mealFilterDataSource: MealFilterDataSource!
    var delegate: GetCategoryListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = mealFilterDataSource
        tableView.delegate = self
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func configure(viewModel: MealFilterViewModel){
        self.viewModel = viewModel
        mealFilterDataSource = MealFilterDataSource(viewModel: viewModel, makeMealFilterCell: appDelegate.dependencyRegistry.makeMealFilterCellMaker)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.getCategoryList(category: self.viewModel.getSelectedCategory())
        }
    }
}

extension MealFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MealFilterTableViewCell {
            cell.categorySelection(status: true)
            viewModel.saveSelectedCategory(viewModel.valueAtIndex(index: indexPath.row)?.categoryName ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MealFilterTableViewCell {
            cell.categorySelection(status: false)
            viewModel.removeSelectedCategory(viewModel.valueAtIndex(index: indexPath.row)?.categoryName ?? "")

        }
    }
}

