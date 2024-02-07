//
//  MealFilterDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 06/02/24.
//

import Foundation
import UIKit

class MealFilterDataSource: NSObject, ListDataSource {
    
    typealias cellType = DependencyRegistry.MealFilterCellMaker
    var viewModel: any ListViewModel
    var makeMealCell: cellType


    init(viewModel: MealFilterViewModel, 
         makeMealFilterCell:@escaping cellType) {
        self.viewModel = viewModel
        self.makeMealCell = makeMealFilterCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeMealCell(tableView, indexPath, self.viewModel.valueAtIndex(index: indexPath.row) as! String)
        return cell
    }
    
    
}
