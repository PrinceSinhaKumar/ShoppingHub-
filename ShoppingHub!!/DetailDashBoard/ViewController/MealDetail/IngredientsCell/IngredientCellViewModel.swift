//
//  IngredientCellViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import Foundation

class IngredientCellViewModel {
    
    var ingName: String
    
    init(model: IngredientModel) {
        self.ingName = "\(model.ingredient ?? "") (\(model.quantity ?? ""))"
    }

}
