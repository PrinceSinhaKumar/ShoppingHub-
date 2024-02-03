//
//  AppDelegate.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit
import CoreData
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var dependencyRegistry: DependencyRegistry!
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.dependencyRegistry = DependencyRegistryImpl(container: container)
        customizeNavigationBar()
        setRootViewController()
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingHub__")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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
    
    func customizeNavigationBar() {
        // Customize navigation bar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.AppBlackTitle.color!]
        // Customize navigation bar back button color
        UINavigationBar.appearance().tintColor = AppColor.AppBlackTitle.color
        // Customize navigation bar background color (if needed)
        UINavigationBar.appearance().barTintColor = AppColor.AppBlackTitle.color
    }
    
    func setRootViewController() {
        
        // Check if user token is available
        if let _ = UserDefaults.standard.value(forKey: uToken) {
            let foodTabController = AppDelegate.dependencyRegistry.makeFoodTabController()
            let navi = UINavigationController(rootViewController: foodTabController)
            window?.rootViewController = navi
        } else {
            let loginViewController = AppDelegate.dependencyRegistry.makeLoginViewController()
            let viewModel = AppDelegate.dependencyRegistry.container.resolve(LoginViewModel.self)!
            loginViewController.initialise(viewModel: viewModel, foodTabControllerMaker: AppDelegate.dependencyRegistry.makeFoodTabController)
            window?.rootViewController = loginViewController
        }
        
        window?.makeKeyAndVisible()
    }
}

