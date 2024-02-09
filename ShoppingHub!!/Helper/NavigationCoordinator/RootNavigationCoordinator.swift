//
//  RootNavigationCoordinator.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 03/02/24.
//

import UIKit
import SafariServices
import Foundation

protocol NavigationCoordinator: AnyObject {
    func next(navState: NavigationState,arguments: Dictionary<String, Any>?)
    func movingBack(navState: NavigationState,arguments: Dictionary<String, Any>?)
    func openRecipe(url: URL)
    func configureNavigationItems(for controller: UIViewController)
}

enum NavigationState {
    case login,
         foodTab,
         foodTopOptionBar,
         foodList,
         mealDetail,
         mealFilter
}

class RootNavigationCoordinatorImpl: NavigationCoordinator {
    
    var registry: DependencyRegistry
    var rootViewController: UIViewController
    
    init(with rootViewController: UIViewController, registry: DependencyRegistry) {
        self.rootViewController = rootViewController
        self.registry = registry
        if rootViewController is FoodTabController || rootViewController is LoginViewController {
            makeRootController(controller: rootViewController)
        }
    }
    
    func movingBack(navState: NavigationState, arguments: Dictionary<String, Any>?) {
        switch navState {
        case .mealFilter: //not possible to move back - do nothing
            self.movingBackFromFilter(arguments: arguments)
        default: //example - do nothing
            break
        }
    }
    
    func next(navState: NavigationState ,arguments: Dictionary<String, Any>?) {
        switch navState {
        case .login: //not possible to move back - do nothing
            showFoodTab(arguments: arguments)
        case .mealDetail:
            showMealDetail(arguments: arguments)
        case .mealFilter:
            gotoFilterController(arguments: arguments)
        default: //example - do nothing
            break
        }
    }
    
    func showFoodTab(arguments: Dictionary<String, Any>?) {
        DispatchQueue.main.async {
            self.makeRootController(controller: self.registry.makeFoodTabController())
        }
    }
    
    func showLoginTab() {
        self.makeRootController(controller: self.registry.makeLoginViewController())
    }
    
    func notifyNilArguments() {
        print("notify user of error")
    }
    
    fileprivate func makeRootController(controller: UIViewController ) {
        let navi = UINavigationController(rootViewController: controller)
        appDelegate.window?.rootViewController = navi
        appDelegate.window?.makeKeyAndVisible()
    }
    
    fileprivate func showMealDetail(arguments: Dictionary<String, Any>?){
        if let meals = arguments?[argumentsKey] as? MealList {
            let vc = registry.mealViewControllerMaker(meal: meals)
            self.rootViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openRecipe(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.navigationController?.present(safariViewController, animated: false)
    }
    
    func gotoFilterController(arguments: Dictionary<String, Any>?) {
        if let categoryList = arguments?[argumentsKey] as? [CategoryModel] {
            let vc = registry.makeMealFilterControllerMaker(categoryList: categoryList)
            vc.delegate = rootViewController.navigationController?.visibleViewController as? MealSearchViewController
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
                rootViewController.navigationController?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func movingBackFromFilter(arguments: Dictionary<String, Any>?) {
       let vc = rootViewController.navigationController?.visibleViewController as? MealFilterViewController
        rootViewController.dismiss(animated: true) {
            if let categoryList = arguments?[argumentsKey] as? [CategoryModel] {
                vc?.delegate?.getCategoryList(category: categoryList)
            }
        }
    }
}
//MARK: Navigation items handling
extension RootNavigationCoordinatorImpl {
    func configureNavigationItems(for controller: UIViewController) {
        switch controller {
        case is FoodTabController:
            // Add navigation items specific to FoodTabController
            let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
            controller.navigationItem.rightBarButtonItem = searchButton
            let logOutButton = UIBarButtonItem(image: .init(systemName: "lock.open.fill"), style: .plain, target: self, action: #selector(logOutButtonTapped))
            controller.navigationItem.leftBarButtonItem = logOutButton
        default:
            let closeButton = UIBarButtonItem(image: .init(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonTapped))
            controller.navigationItem.leftBarButtonItem = closeButton
        }
    }
    
    @objc func searchButtonTapped() {
        let list = MealDataProvider.shared.fetchMeals()
        let vc = registry.mealSearchControllerMaker(meal: list.map({MealList(meal: $0)}))
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func closeButtonTapped() {
        rootViewController.navigationController?.popViewController(animated: true)
    }
    
    @objc func logOutButtonTapped() {
        let mealDB = registry.container.resolve(MealDataManagerDelegate.self)
        mealDB?.deleteAllMealFromDB()
        UserDefaults.standard.removeObject(forKey: uToken)
        showLoginTab()
    }
}
