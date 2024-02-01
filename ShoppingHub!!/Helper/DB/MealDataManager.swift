//
//  MealDataManager.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation
import CoreData

final class MealDataManager {
    
    static let shared = MealDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
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
            guard
                let idMeal = mealInfo.idMeal,
                let strMeal = mealInfo.strMeal,
                // Add additional non-nil checks for other properties as needed
                let strDrinkAlternate = mealInfo.strDrinkAlternate,
                let strCategory = mealInfo.strCategory,
                let strArea = mealInfo.strArea,
                let strInstructions = mealInfo.strInstructions,
                let strMealThumb = mealInfo.strMealThumb,
                let strTags = mealInfo.strTags,
                let strYoutube = mealInfo.strYoutube
            else {
                // Skip this iteration if any required property is nil
                continue
            }
            
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", idMeal)
            
            if let existingMeal = try? context.fetch(fetchRequest).first {
                // If meal with the same idMeal exists, update it
                existingMeal.strMeal = strMeal
                existingMeal.strDrinkAlternate = strDrinkAlternate
                existingMeal.strCategory = strCategory
                existingMeal.strArea = strArea
                existingMeal.strInstructions = strInstructions
                existingMeal.strMealThumb = strMealThumb
                existingMeal.strTags = strTags
                existingMeal.strYoutube = strYoutube
                existingMeal.modifiedDate = Date()
            } else {
                let meal = Meal(context: context)
                meal.idMeal = idMeal
                meal.strMeal = strMeal
                meal.strDrinkAlternate = strDrinkAlternate
                meal.strCategory = strCategory
                meal.strArea = strArea
                meal.strInstructions = strInstructions
                meal.strMealThumb = strMealThumb
                meal.strTags = strTags
                meal.strYoutube = strYoutube
                meal.modifiedDate = Date()
            }
        }
        
        saveContext()
    }


//    func saveMeals(mealData: FoodListDecodableModel?) {
//        
//        guard let meals = mealData?.meals else { return }
//        
//        let context = persistentContainer.viewContext
//        
//        for mealInfo in meals {
//            guard let idMeal = mealInfo.idMeal else {
//                        // Skip this iteration if idMeal is nil
//                        continue
//                    }
//                    
//            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", idMeal)
//            if let existingMeal = try? context.fetch(fetchRequest).first {
//                // If meal with the same idMeal exists, update it
//                existingMeal.strMeal = mealInfo.strMeal
//                existingMeal.strDrinkAlternate = mealInfo.strDrinkAlternate
//                existingMeal.strCategory = mealInfo.strCategory
//                existingMeal.strArea = mealInfo.strArea
//                existingMeal.strInstructions = mealInfo.strInstructions
//                existingMeal.strMealThumb = mealInfo.strMealThumb
//                existingMeal.strTags = mealInfo.strTags
//                existingMeal.strYoutube = mealInfo.strYoutube
//                existingMeal.modifiedDate = Date()
//            } else {
//                let meal = Meal(context: context)
//                meal.idMeal = mealInfo.idMeal
//                meal.strMeal = mealInfo.strMeal
//                meal.strDrinkAlternate = mealInfo.strDrinkAlternate
//                meal.strCategory = mealInfo.strCategory
//                meal.strArea = mealInfo.strArea
//                meal.strInstructions = mealInfo.strInstructions
//                meal.strMealThumb = mealInfo.strMealThumb
//                meal.strTags = mealInfo.strTags
//                meal.strYoutube = mealInfo.strYoutube
//                meal.modifiedDate = Date()
//            }
//        }
//        
//        saveContext()
//        
//    }
}
