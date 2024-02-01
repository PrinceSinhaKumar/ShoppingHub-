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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }

    //MARK: - Method
    fileprivate func initialise(){
        viewModel = LoginViewModel(model: LoginModel())
        applyGradient()
        configureUI()
        configureObserver()
    }
    
    fileprivate func applyGradient() {
        guard let viewModel = viewModel else { return }
        let myGradientView = GradientBackgroundView(frame: view.bounds)
        view.insertSubview(myGradientView, at: 0)
        // dynamically updating the color set
        myGradientView.colorSet = viewModel.gradientColors
    }
    
    fileprivate func configureUI(){
        emailTextField.font = AppFont.font(with: 15, family: OpenSans.regular)
        passwordTextField.font = AppFont.font(with: 15, family: OpenSans.regular)
        loginButton.titleLabel?.font = AppFont.font(with: 15, family: OpenSans.medium)
        loginButton.tintColor = .appBlackTitle
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
        DispatchQueue.main.async { [weak self] in
            let vc = UIStoryboard(name: "FoodStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FoodTabController") as? FoodTabController
            vc?.viewModel = FoodTabViewModel(model: FoodTabModel())
            self?.navigationController?.pushViewController(vc!, animated: false)
        }
    }
}

