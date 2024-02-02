//
//  RealodFoodModel.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 31/01/24.
//

import Foundation

protocol ReloadFoodModelDelegate {
    var operationQueue: OperationQueue { get }
    func fetchFoodList(handler: @escaping Handler)
}

class ReloadFoodModel: ReloadFoodModelDelegate {
    
    let operationQueue = OperationQueue()
    
    func fetchFoodList(handler: @escaping Handler){
       
        // Set the maximum number of concurrent operations
        operationQueue.maxConcurrentOperationCount = 1
        
        // Call the API with each alphabetical keyword
        var operations: [APICallOperation] = []
        
        for char in UnicodeScalar("a").value...UnicodeScalar("z").value {
            let keyword = String(Character(UnicodeScalar(char)!))
            let operation = APICallOperation(keyword: keyword).callApi {  meals, error in
                // Handle completion of individual operation
                guard error == nil else {
                    self.operationQueue.cancelAllOperations()
                    handler(nil, error)
                    return
                }
                if keyword.uppercased() == "Z" {
                    handler(meals, error)
                }
            }
            operations.append(operation)
        }
        
        // Add operations to the queue
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
}

protocol APICalllOperationDelegate {
    var keyword: String { get }
    func callApi(completion: @escaping Handler) -> Self
}

class APICallOperation: Operation, APICalllOperationDelegate{
    var keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
        super.init()
    }
    
    func callApi(completion: @escaping Handler) -> Self {
        guard !isCancelled else {
            return self
        }
        
        ApiManager.shared.getData(from: .getFoodList(keyword)) { meals, error in
            MealDataManager.shared.saveMeals(mealData: meals)
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(meals, nil)
            
        }
        return self
    }
}
