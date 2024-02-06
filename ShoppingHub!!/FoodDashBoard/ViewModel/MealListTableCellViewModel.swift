//
//  MealListTableCellViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 01/02/24.
//

import Foundation

struct MealCellViewModel {
    let strMeal: String
    let strCategory: String
    let mealImageURL: URL
    let ingridients: String
    let youtubeURL: String
    let mealId: String
    var isFavourite: Bool
    var searchedText: String
    
    init(meal: MealList) {
        self.strMeal = meal.strMeal ?? ""
        self.strCategory = meal.strCategory ?? ""
        self.mealImageURL = URL(string: meal.strMealThumb ?? "")!
        self.ingridients = (meal.indredients?.count.description)!
        self.youtubeURL = meal.strYoutube ?? ""
        self.mealId = meal.idMeal ?? ""
        self.isFavourite = meal.isFavourite
        self.searchedText = meal.searchedText
    }
    
    func getYoutubeURL() -> URL{
        return URL(string: youtubeURL)!
    }
    
    mutating func updateFavourite(_ status: Bool){
        self.isFavourite = status
    }
}
