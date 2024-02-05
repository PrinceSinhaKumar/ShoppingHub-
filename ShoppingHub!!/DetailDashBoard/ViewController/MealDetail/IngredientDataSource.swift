//
//  IngredientDataSource.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import Foundation
import UIKit

class IngredientDataSource: NSObject, UICollectionViewDataSource {
    
    fileprivate var viewModel: MealDetailViewModel!
    fileprivate let ingredientCellMaker: DependencyRegistry.MakeMealIngredientCellMaker

    init(ingredientCellMaker: @escaping DependencyRegistry.MakeMealIngredientCellMaker) {
        self.ingredientCellMaker = ingredientCellMaker
    }
    
    func configure(viewModel: MealDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.totalNumberOfIngredients()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ingredientCellMaker(collectionView, indexPath, viewModel.getIngredient(at: indexPath.item))
        return cell
    }
 
}
