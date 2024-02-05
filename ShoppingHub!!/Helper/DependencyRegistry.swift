//
//  DependenciesRegistry.swift
//  ShoppingHub!!
//
//  Created by Prince Shrivastav on 03/02/24.
//

import UIKit
import Swinject

protocol DependencyRegistry {
    var container: Container { get }
    var navigationCoordinator: NavigationCoordinator! { get }
    
    typealias rootNavigationCoordinator = (UIViewController) -> NavigationCoordinator
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator
    
    typealias MealCellMaker = (UITableView, IndexPath, MealList) -> MealCell
    func makeMealCell(for tableView: UITableView, at indexPath: IndexPath, meal: MealList) -> MealCell

    typealias FoodTabControllerMaker = () -> FoodTabController
    func makeFoodTabController() -> FoodTabController
    
    typealias MealListTableViewControllerMaker = ([MealList]) -> MealListTableViewController
    func makeMealListTableViewControllerMaker (meals: [MealList]) -> MealListTableViewController
    
    typealias LoginViewControllerMaker = () -> LoginViewController
    func makeLoginViewController() -> LoginViewController
    
    typealias MealDetailViewControllerMaker = () -> MealDetailViewController
    func mealDetailViewControllerMaker() -> MealDetailViewController
    
    typealias MealViewControllerMaker = (MealList) -> MealViewController
    func mealViewControllerMaker(meal: MealList) -> MealViewController
    
    typealias MakeMealIngredientCellMaker = (UICollectionView,IndexPath,IngredientModel) -> IngredientCell
    func makeMealIngredientCell(for collectionView: UICollectionView, at indexPath: IndexPath, model: IngredientModel) -> IngredientCell

}

class DependencyRegistryImpl: DependencyRegistry {

    var container: Container
    var navigationCoordinator: NavigationCoordinator!

    init(container: Container) {
        
        Container.loggingFunction = nil
        
        self.container = container
        
        registerDependencies()
        registerViewModels()
        registerViewControllers()
    }
    
    func registerDependencies() {
        container.register(NavigationCoordinator.self) { (r, rootViewController: UIViewController) in
            return RootNavigationCoordinatorImpl(with: rootViewController, registry: self)
        }.inObjectScope(.container)
        
        container.register(ApiManagerDelegate.self ) { _ in ApiManager.shared }.inObjectScope(.container)
        
        container.register(MealDataManagerDelegate.self ) { _ in MealDataManager.shared }.inObjectScope(.container)
        
        container.register(ReloadFoodModelDelegate.self ) { _ in ReloadFoodModel() }.inObjectScope(.container)
        
        container.register(APICalllOperationDelegate.self) { r in
            APICallOperation(keyword: r.resolve(String.self) ?? "")
        }.inObjectScope(.container)
        
        container.register(LoginModelDelegate.self) { _ in LoginModel() }.inObjectScope(.container)
        
        container.register((FoodTabModelDelegate).self) { _ in FoodTabModel() }.inObjectScope(.container)
        
        container.register(String.self) { _ in String() }.inObjectScope(.container)
        
        container.register(MealDetailModel.self) { ( _ , meal: MealList) in MealDetailModel(meal: meal) }
                        
    }
    
    func registerViewModels() {
        container.register(LoginViewModel.self) { r in
            
            LoginViewModel(model: r.resolve(LoginModelDelegate.self)!, reloadFoodModel: r.resolve(ReloadFoodModelDelegate.self)!)
            
        }.inObjectScope(.container)
        
        container.register(FoodTabViewModelDelegate.self) { r in
            FoodTabViewModel(model: r.resolve(FoodTabModelDelegate.self)!)
        }.inObjectScope(.container)

        container.register(FoodTopOptionbarViewModelDelegate.self) { (r, menuList: [String], meals: [MealList] ) in FoodTopOptionbarViewModel(menuList: menuList, meals: meals) }.inObjectScope(.container)
        
        container.register(MealListViewModel.self) { (r, meals: [MealList]) in
            MealListViewModel(list: meals)
        }
        container.register(MealCellViewModel.self) { (r, meal: MealList) in
            MealCellViewModel(meal: meal)
        }
        
        container.register(MealListDataSource.self) { (r, meal: [MealList]) in
            let viewModel = r.resolve(MealListViewModel.self, argument: meal)!
            return MealListDataSource(viewModel: viewModel)
        }
        
        container.register(MealDetailViewModel.self) { (r, meal: MealList) in
            MealDetailViewModel(model: r.resolve(MealDetailModel.self, argument: meal)!)
        }

        container.register(IngredientCellViewModel.self) { (_, model: IngredientModel) in
            IngredientCellViewModel(model: model)
        }
        
        container.register(IngredientDataSource.self) { r in
            let cellMaker = self.makeMealIngredientCell
            return IngredientDataSource(ingredientCellMaker: cellMaker)
        }
    }
    
    func registerViewControllers() {
       
        container.register(LoginViewController.self) { r in
            let vc = Storyboard.Main.value?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            return vc
        }
        
        container.register(FoodTabController.self) { r in
            let viewModel = r.resolve(FoodTabViewModelDelegate.self)!
            let vc = Storyboard.FoodStoryboard.value?.instantiateViewController(withIdentifier: "FoodTabController") as! FoodTabController
            self.navigationCoordinator = self.makeRootNavigationCoordinator(rootViewController: vc)
            vc.configure(viewModel: viewModel, navigationCoordinator: self.navigationCoordinator)
            return vc
        }
        container.register(MealListTableViewController.self) { (r, meal: [MealList]) in
            let viewModel = r.resolve(MealListViewModel.self, argument: meal)!
            let dataSource = r.resolve(MealListDataSource.self, argument: meal)!
            let vc = Storyboard.FoodStoryboard.value?.instantiateViewController(withIdentifier: "MealListTableViewController") as! MealListTableViewController
            vc.configure(viewModel: viewModel, mealListDataSource: dataSource, coordinator: self.navigationCoordinator)
            return vc
        }
        
        container.register(MealDetailViewController.self) { r in
            let vc = Storyboard.MealDetailStoryboard.value?.instantiateViewController(withIdentifier: "MealDetailViewController") as! MealDetailViewController
            return vc
        }
        
        container.register(MealViewController.self) { (r, meal: MealList) in
            let viewModel = r.resolve(MealDetailViewModel.self, argument: meal)!
            let vc = Storyboard.MealDetailStoryboard.value?.instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
            self.navigationCoordinator = self.makeRootNavigationCoordinator(rootViewController: vc)
            vc.configure(viewModel: viewModel, mealDetailViewControllerMaker: self.mealDetailViewControllerMaker, ingredientDataSource: r.resolve(IngredientDataSource.self)!)
            return vc
        }

    }

    //MARK: - Maker Methods
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator {
        navigationCoordinator = container.resolve(NavigationCoordinator.self, argument: rootViewController)!
        return navigationCoordinator
    }
    
    func makeLoginViewController() -> LoginViewController {
        return container.resolve(LoginViewController.self)!
    }
    
    func makeMealCell(for tableView: UITableView, at indexPath: IndexPath, meal: MealList) -> MealCell{
        tableView.register(UINib(nibName: "MealCell", bundle: nil), forCellReuseIdentifier: "MealCell")
        let viewModel = container.resolve(MealCellViewModel.self, argument: meal)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        cell.configure(viewModel: viewModel, coordinator: self.navigationCoordinator)
        return cell
    }

    func makeFoodTabController() -> FoodTabController {
        return container.resolve(FoodTabController.self)!
    }
    
    func makeMealListTableViewControllerMaker (meals: [MealList]) -> MealListTableViewController {
        return container.resolve(MealListTableViewController.self, argument: meals)!
    }
    
    func mealDetailViewControllerMaker() -> MealDetailViewController {
        return container.resolve(MealDetailViewController.self)!
    }

    func makeMealIngredientCell(for collectionView: UICollectionView, at indexPath: IndexPath, model: IngredientModel) -> IngredientCell {
        let viewModel = container.resolve(IngredientCellViewModel.self, argument: model)!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        cell.viewModel = viewModel
        return cell
    }
    
    func mealViewControllerMaker(meal: MealList) -> MealViewController {
        container.resolve(MealViewController.self, argument: meal)!
    }
}


