//
//  MealDataProvider.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 29/01/24.
//

import Foundation
import CoreData

final class MealDataProvider {
    
    static let shared = MealDataProvider()
    private init() {}
    
    let context = MealDataManager.shared.persistentContainer.viewContext
    
    func fetchMeals() -> [Meal] {
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "modifiedDate", ascending: true)]
        do {
            let meals = try context.fetch(fetchRequest)
            return meals
        } catch {
            print("Error fetching meals: \(error)")
            return []
        }
    }
}
