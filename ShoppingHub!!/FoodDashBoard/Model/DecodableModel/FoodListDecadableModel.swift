//
//  FoodListDecadableModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import Foundation

struct FoodListDecodableModel: Decodable {
    var meals: [Meals]?
}

struct Meals: Decodable {

    var idMeal: String? = ""
    var strMeal: String? = ""
    var strDrinkAlternate: String? = ""
    var strCategory: String? = ""
    var strArea: String? = ""
    var strInstructions: String? = ""
    var strMealThumb: String? = ""
    var strTags: String? = ""
    var strYoutube: String? = ""
    
    init(meal: Meal) {
        self.idMeal = meal.idMeal
        self.strMeal = meal.strMeal
        self.strDrinkAlternate = meal.strDrinkAlternate
        self.strCategory = meal.strCategory
        self.strArea = meal.strArea
        self.strInstructions = meal.strInstructions
        self.strMealThumb = meal.strMealThumb
        self.strTags = meal.strTags
        self.strYoutube = meal.strYoutube
    }
}
