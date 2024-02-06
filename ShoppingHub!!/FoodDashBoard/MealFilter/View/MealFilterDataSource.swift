//
//  MealFilterDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import Foundation
import UIKit

class MealFilterDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: MealFilterViewModel
    fileprivate var makeMealFilterCell: DependencyRegistry.MealFilterCellMaker

    init(viewModel: MealFilterViewModel, 
         makeMealFilterCell:@escaping DependencyRegistry.MealFilterCellMaker) {
        self.viewModel = viewModel
        self.makeMealFilterCell = makeMealFilterCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeMealFilterCell(tableView, indexPath, self.viewModel.getCategoryAtIndex(index: indexPath.row)!)
        return cell
    }
    
    
}
