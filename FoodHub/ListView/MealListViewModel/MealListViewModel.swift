//
//  MealListViewModel.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 04/05/24.
//

import SwiftUI
import Combine

class MealListViewModel: ViewModel {
    var model: MealListModel
    var cancellable: Set<AnyCancellable>
    @Published var errorMessage: String = ""
    @Published var successPublisher = PassthroughSubject<Void, Never>()
    @Published var isLoading: Bool = false
    @Published var showToastView: Bool = false
    
    @Published var meals: [MealDataList] = []

    init(model: MealListModel, cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.model = model
        self.cancellable = cancellable
    }
    
    func fetchMealList() {
        meals = []
        model.fetchData()
            .sink { completion in
                if case .failure(let error) = completion {
                    self.showToastView.toggle()
                    self.errorMessage = error.description
                }
                self.isLoading.toggle()
            } receiveValue: { data in
                self.meals.append(contentsOf: self.model.listData.map({.init(meal: $0)}))
                self.successPublisher.send()
            }
            .store(in: &cancellable)

    }
    // Publisher to observe successful login
    func observeSuccess() -> AnyPublisher<Void, Never> {
        successPublisher.eraseToAnyPublisher()
    }
}
