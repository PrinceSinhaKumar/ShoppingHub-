//
//  MealListModel.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 04/05/24.
//

import Combine
import Foundation

protocol ListModel: Model {
    associatedtype L
    var listData: [L] {get set}
}

class MealListModel: ListModel {
    
    var data: FoodListDecodableModel?
    var apiContainer: Encodable? = nil
    var listData: [Meals] = []
    
    func fetchData() -> AnyPublisher<FoodListDecodableModel, ApiError> {
        
        let group = DispatchGroup()
        var publishers: [AnyPublisher<FoodListDecodableModel, ApiError>] = []
        for char in UnicodeScalar("a").value...UnicodeScalar("z").value {
            group.enter()
            let keyword = String(Character(UnicodeScalar(char)!))
            if let publisher = NetworkManager.shared.fetchNetworkRequest(from: .getFoodList(keyword), body: apiContainer) as AnyPublisher<FoodListDecodableModel, ApiError>? {
                let processedPublisher = publisher
                    .handleEvents(receiveOutput: { [weak self] result in
                        self?.data = result
                        if let meals = result.meals {
                            self?.listData.append(contentsOf: meals)
                        }
                    })
                    .eraseToAnyPublisher()
                publishers.append(processedPublisher)
                group.leave()
            } else {
                group.leave()
            }
        }
        return Deferred {
            Future { promise in
                group.notify(queue: .global()) {
                    if !publishers.isEmpty {
                        // Combine all publishers into one with merge operator
                        let combinedPublisher = Publishers.MergeMany(publishers)
                        promise(.success(combinedPublisher))
                    } else {
                        promise(.failure(ApiError.parseError))
                    }
                }
            }
        }
        .flatMap { $0 }
        .eraseToAnyPublisher()
    }
   
}
