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
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func tapFilterButton(_ sender: Any){
        let dict:Dictionary<String, Any> = [argumentsKey : viewModel.getCategoryList() as Any]
        coordinator.next(navState: .mealFilter, arguments: dict)
    }
}
extension MealSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.next(navState: .mealDetail, arguments: [argumentsKey: viewModel?.valueAtIndex(index: indexPath.row) as Any])
    }
    
}
extension MealSearchViewController: GetCategoryListDelegate {

   @objc func textFieldDidChange(textField: UITextField) {
       viewModel.searchedData(text: textField.text ?? "")
       tableView.reloadData()
    }
    
    func getCategoryList(category: [CategoryModel]) {
        viewModel.saveSelectedCategory(selected: category)
        if let text = searchTextField.text {
            viewModel.searchedData(text: text)
        }
        tableView.reloadData()
    }
}
