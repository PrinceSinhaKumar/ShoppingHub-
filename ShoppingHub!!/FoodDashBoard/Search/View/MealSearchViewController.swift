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
    }
    
    @IBAction func tapFilterButton(_ sender: Any){
        let vc = Storyboard.FoodStoryboard.value?.instantiateViewController(withIdentifier: "MealFilterViewController") as! MealFilterViewController
        let nav = UINavigationController(rootViewController: vc)
        // 1
        nav.modalPresentationStyle = .pageSheet
        // 2
        if let sheet = nav.sheetPresentationController {
            // 3
            sheet.detents = [.medium(), .large()]
        }
        // 4
        present(nav, animated: true, completion: nil)
    }
}
extension MealSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.next(navState: .mealDetail, arguments: [argumentsKey: viewModel?.mealAtIndex(index: indexPath.row) as Any])
    }
    
}
extension MealSearchViewController {
   @objc func textFieldDidChange(textField: UITextField) {
       viewModel.searchedData(text: textField.text ?? "")
       tableView.reloadData()
    }
}
