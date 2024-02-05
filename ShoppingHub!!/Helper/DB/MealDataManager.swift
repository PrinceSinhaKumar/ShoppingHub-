//
//  MealDataManager.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation
import CoreData

protocol MealDataManagerDelegate {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext ()
    func saveMeals(mealData: FoodListDecodableModel?)
    func addFavouriteMeal(mealId: String, isFavourite: Bool)
}

final class MealDataManager: MealDataManagerDelegate {
    
    static let shared = MealDataManager()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingHub__") // Replace "Model" with your Core Data model file name
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveMeals(mealData: FoodListDecodableModel?) {
        guard let meals = mealData?.meals else { return }
        
        let context = persistentContainer.viewContext
        
        for mealInfo in meals {
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", mealInfo.idMeal!)
            
            if let existingMeal = try? context.fetch(fetchRequest).first {
                updateMeal(existingMeal, with: mealInfo, context: context)
            } else {
                createNewMeal(with: mealInfo, context: context)
            }
        }
        
        saveContext()
    }

    private func updateMeal(_ meal: Meal, with mealInfo: Meals, context: NSManagedObjectContext) {
        meal.strMeal = mealInfo.strMeal
        meal.strDrinkAlternate = mealInfo.strDrinkAlternate
        meal.strCategory = mealInfo.strCategory
        meal.strArea = mealInfo.strArea
        meal.strInstructions = mealInfo.strInstructions
        meal.strMealThumb = mealInfo.strMealThumb
        meal.strTags = mealInfo.strTags
        meal.strYoutube = mealInfo.strYoutube
        meal.modifiedDate = Date()
        updateIngredients(for: meal, with: mealInfo, context: context)
    }

    private func createNewMeal(with mealInfo: Meals, context: NSManagedObjectContext) {
        let meal = Meal(context: context)
        meal.idMeal = mealInfo.idMeal
        meal.strMeal = mealInfo.strMeal
        meal.strDrinkAlternate = mealInfo.strDrinkAlternate
        meal.strCategory = mealInfo.strCategory
        meal.strArea = mealInfo.strArea
        meal.strInstructions = mealInfo.strInstructions
        meal.strMealThumb = mealInfo.strMealThumb
        meal.strTags = mealInfo.strTags
        meal.strYoutube = mealInfo.strYoutube
        meal.isFavourite = meal.isFavourite
        meal.modifiedDate = Date()
        
        updateIngredients(for: meal, with: mealInfo, context: context)
    }

    private func updateIngredients(for meal: Meal, with mealInfo: Meals, context: NSManagedObjectContext) {
        let ingredients = Mirror(reflecting: mealInfo).children.filter { $0.label?.starts(with: "strIngredient") ?? false }
        let measures = Mirror(reflecting: mealInfo).children.filter { $0.label?.starts(with: "strMeasure") ?? false }
        
        for (ingredient, measure) in zip(ingredients, measures) {
            if let ingredientValue = ingredient.value as? String,
               let measureValue = measure.value as? String,
               !ingredientValue.isEmpty {
                let newIngredient = Ingredients(context: context)
                newIngredient.ingredient = ingredientValue
                newIngredient.ingQuantity = measureValue
                meal.addToIngredient(newIngredient)
            }
        }
    }

    func addFavouriteMeal(mealId: String, isFavourite: Bool) {
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idMeal == %@", mealId)
        let context = persistentContainer.viewContext
        
        if let existingMeal = try? context.fetch(fetchRequest).first {
            updateFavouriteStatus(for: existingMeal, isFavourite: isFavourite)
        }
        saveContext()
    }
    
    // Add this new method to update isFavourite property
       private func updateFavouriteStatus(for meal: Meal, isFavourite: Bool) {
           meal.isFavourite = isFavourite
           meal.modifiedDate = Date()
           let dict: [String: Any?] = [observerID: meal.idMeal, observerIsFavt: isFavourite]
           NotificationCenter.default.post(name: Notification.Name(reloadMealCell), object: dict)
       }
}
