//
//  SceneDelegate.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
        
    private let coordinator: NavigationCoordinatorManager<Router> = .init(startingRoute: .mealListView)
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}
