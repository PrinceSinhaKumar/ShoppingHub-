//
//  FoodListDecadableModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 28/01/24.
//

import Foundation

struct FoodListDecodableModel: Decodable {
    let meals: [Meals]?
}

struct Meals: Decodable {

    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    
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
