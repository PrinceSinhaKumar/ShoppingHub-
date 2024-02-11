//
//  FoodHubApp.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

@main
struct FoodHubApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(model: LoginModel(), reloadFoodModel: ReloadFoodModel()))
        }
    }
}
