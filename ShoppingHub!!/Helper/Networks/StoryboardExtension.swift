//
//  StoryboardExtension.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 01/02/24.
//

import UIKit

enum Storyboard: String {
    
    case Main
    case FoodStoryboard
    case MealDetailStoryboard
    
    var value: UIStoryboard? {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
