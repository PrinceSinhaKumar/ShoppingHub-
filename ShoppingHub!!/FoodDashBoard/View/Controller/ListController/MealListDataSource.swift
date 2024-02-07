//
//  ListDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 31/01/24.
//

import Foundation
import UIKit
import Kingfisher

protocol ListDataSource: UITableViewDataSource {
    associatedtype cellType
    var viewModel: any ListViewModel { get }
    var makeMealCell: cellType { get }//DependencyRegistry.MealCellMaker!
}

class MealListDataSource: NSObject, ListDataSource {
    
    typealias cellType = DependencyRegistry.MealCellMaker
    let viewModel: any ListViewModel
    var makeMealCell: DependencyRegistry.MealCellMaker

    init(viewModel: any ListViewModel,
         makeMealCell:@escaping DependencyRegistry.MealCellMaker)
    {
        self.viewModel = viewModel
        self.makeMealCell = makeMealCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeMealCell(tableView, indexPath, viewModel.valueAtIndex(index: indexPath.row)! as! MealList)
        return cell
    }
    
}
