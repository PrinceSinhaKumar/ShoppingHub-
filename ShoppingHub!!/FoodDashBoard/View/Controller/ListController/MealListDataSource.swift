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
    
    let viewModel: ListViewModel
    fileprivate var makeMealCell: DependencyRegistry.MealCellMaker!
    
    init(viewModel: ListViewModel,
         makeMealCell:@escaping DependencyRegistry.MealCellMaker)
    {
        self.viewModel = viewModel
        self.makeMealCell = makeMealCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeMealCell(tableView, indexPath, viewModel.mealAtIndex(index: indexPath.row)!)
        return cell
    }
    
}
