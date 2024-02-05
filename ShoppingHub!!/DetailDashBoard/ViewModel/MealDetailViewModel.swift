//
//  MealDetailViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 04/02/24.
//

import Foundation

class MealDetailViewModel {
    
    let model: MealDetailModel
    
    init(model: MealDetailModel) {
        self.model = model
    }
    
    func getMeal() -> MealList{
        self.model.meal
    }
    
    func totalNumberOfIngredients() -> Int {
        getMeal().indredients?.count ?? 0
    }
    
    func getIngredient(at index: Int) -> IngredientModel {
        getMeal().indredients![index]
    }
    
    func totalSteps() -> NSMutableAttributedString {
        var attributedString = NSMutableAttributedString()
        var count = 1
        getMeal().strInstructions?.split(separator: .init(".")).forEach({ step in
            
            let number = NSAttributedString(string: "\nStep \(count): ", attributes: [
                NSAttributedString.Key.font : AppFont.font(with: 13, family: OpenSans.medium),
                NSAttributedString.Key.foregroundColor: AppColor.AppOrange.color!
            ])
            
            let instruction = NSAttributedString(string: step.description, attributes: [
                NSAttributedString.Key.font : AppFont.font(with: 12, family: OpenSans.regular),
                NSAttributedString.Key.foregroundColor: AppColor.AppBlackTitle.color!
            ])
            
            let str = NSMutableAttributedString(attributedString: number)
            str.append(instruction)
            
            attributedString.append(str)
            count += 1
        })
       return attributedString
    }
}
