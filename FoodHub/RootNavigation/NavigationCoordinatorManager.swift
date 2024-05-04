//
//  NavigationConfiguration.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 02/05/24.
//

import SwiftUI

public enum NavigationTransitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

public protocol NavigationRouter {
    associatedtype V: View
    var transition: NavigationTransitionStyle { get }
    @ViewBuilder
    func view() -> V
}

open class NavigationCoordinatorManager<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    
    init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            /// because there is a leak in UIHostingControllers that prevents from deallocation
            self?.navigationController.viewControllers = []
        }
    }
}

public enum Router: NavigationRouter {
    
    case login, mealListView
    
    public var transition: NavigationTransitionStyle {
        switch self {
        case .login:
            return .push
        case .mealListView:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        NavigationConfiguration {
            switch self {
            case .login:
                LoginView(viewModel: LoginViewModel(model: LoginModel()))
            case .mealListView:
                MealListView(viewModel: MealListViewModel(model: MealListModel()))
            }
        }
        
    }
    
}

struct NavigationConfiguration<Content>: View where Content: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        // Customize the appearance of navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.backgroundColor = AppColor.AppOrange.color
        appearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            content
        }
    }
}
