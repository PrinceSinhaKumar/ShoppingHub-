//
//  ListDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 31/01/24.
//

import Foundation
import UIKit
import Kingfisher

class MealListDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: MealListViewModel
    let cellIdentifier: String
    
    init(cellIdentifier: String, viewModel: MealListViewModel, tableview: UITableView) {
        self.viewModel = viewModel
        self.cellIdentifier = cellIdentifier
        tableview.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        if let cell = cell as? MenuListTableViewCell , let model = viewModel.list?[indexPath.row] {
            cell.viewModel = MenuListCellViewModel(meal: model)
        }
        return cell
    }
    
}
