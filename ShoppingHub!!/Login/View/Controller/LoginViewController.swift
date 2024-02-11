//
//  LoginViewController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var emailTextField, passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    fileprivate var viewModel: LoginViewModel?
    //fileprivate var foodTabControllerMaker: DependencyRegistry.FoodTabControllerMaker!
    fileprivate var navigationCoordinator: NavigationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Method
    func initialise(viewModel: LoginViewModel,
                    navigationCoordinator: NavigationCoordinator?){
        self.viewModel = viewModel
        self.navigationCoordinator = navigationCoordinator
        applyGradient()
        configureUI()
        configureObserver()
    }
    
    fileprivate func applyGradient() {
        guard let viewModel = viewModel else { return }
        let myGradientView = GradientBackgroundUIView(frame: view.bounds)
        view.insertSubview(myGradientView, at: 0)
        // dynamically updating the color set
        myGradientView.colorSet = viewModel.gradientColors
    }
    
    fileprivate func configureUI(){
        emailTextField.font = AppFont.font(with: 15, family: OpenSans.regular)
        passwordTextField.font = AppFont.font(with: 15, family: OpenSans.regular)
        loginButton.titleLabel?.font = AppFont.font(with: 15, family: OpenSans.medium)
        loginButton.tintColor = AppColor.AppBlackTitle.color
    }
    
    fileprivate func configureObserver(){
        viewModel?.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading: ActivityIndicator.shared.startAnimating()
                case .stopLoading: ActivityIndicator.shared.stopAnimating()
                case .dataLoaded:
                    self.reloadMealsList()
                case .error(let error):
                    ShoppingAlert.shared.showAlert(error)
                }
            }
            
        }
    }
    
    @IBAction func loginButtonTap() {
       viewModel?.fetchLogin(loginData: LoginModelEncodable(username: "admin", password: "password123"))
    }
    
    fileprivate func reloadMealsList(){
        viewModel?.fetchMealsData(complition: { [weak self] in
            self?.moveToFoodTab()
        })
    }
    
    fileprivate func moveToFoodTab(){
        navigationCoordinator?.next(navState: .login, arguments: nil)
    }
}

