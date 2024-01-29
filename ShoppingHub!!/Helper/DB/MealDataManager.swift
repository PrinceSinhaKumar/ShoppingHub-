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
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", mealInfo.idMeal!)
            if let existingMeal = try? context.fetch(fetchRequest).first {
                // If meal with the same idMeal exists, update it
                existingMeal.strMeal = mealInfo.strMeal
                existingMeal.strDrinkAlternate = mealInfo.strDrinkAlternate
                existingMeal.strCategory = mealInfo.strCategory
                existingMeal.strArea = mealInfo.strArea
                existingMeal.strInstructions = mealInfo.strInstructions
                existingMeal.strMealThumb = mealInfo.strMealThumb
                existingMeal.strTags = mealInfo.strTags
                existingMeal.strYoutube = mealInfo.strYoutube
                existingMeal.modifiedDate = Date()
            } else {
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
                meal.modifiedDate = Date()
            }
        }
        
        saveContext()
        
    }
}
