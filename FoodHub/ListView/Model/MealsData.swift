//
//  MealsData.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 04/05/24.
//

import Combine
import Foundation
import SwiftUI

class MealDataList:Identifiable, ObservableObject {
    
    var id: UUID = UUID()
    @Published var idMeal: String? = ""
    @Published var strMeal: String? = ""
    @Published var strDrinkAlternate: String? = ""
    @Published var strCategory: String? = ""
    @Published var strArea: String? = ""
    @Published var strInstructions: String? = ""
    @Published var strMealThumb: String? = ""
    @Published var strTags: String? = ""
    @Published var strYoutube: String? = ""
    //var indredients: [IngredientData]? = []
    //var isFavourite: Bool = false
    
    init(meal: Meals) {
        self.idMeal = meal.idMeal
        self.strMeal = meal.strMeal
        self.strDrinkAlternate = meal.strDrinkAlternate
        self.strCategory = meal.strCategory
        self.strArea = meal.strArea
        self.strInstructions = meal.strInstructions
        self.strMealThumb = meal.strMealThumb
        self.strTags = meal.strTags
        self.strYoutube = meal.strYoutube

//        indredients?.append(contentsOf: (meal.ingredient?.allObjects.map({IngredientData(value: ($0 as? Ingredients)!)}))!)
//        self.isFavourite = meal.isFavourite
    }
    
}

struct IngredientData {
    var ingredient: String? = ""
    var quantity: String? = ""
    
    init(value: Ingredients) {
        self.ingredient = value.ingredient
        self.quantity = value.ingQuantity
    }
}
