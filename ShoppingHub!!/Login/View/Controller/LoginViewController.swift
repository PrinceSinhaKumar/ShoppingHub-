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
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }

    //MARK: - Method
    fileprivate func initialise(){
        applyGradient()
        viewModel = LoginViewModel(model: LoginModel())
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
    }
    
    fileprivate func configureObserver(){
        viewModel?.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading: ActivityIndicator.shared.startAnimating()
                case .stopLoading: ActivityIndicator.shared.stopAnimating()
                case .dataLoaded:
                    ShoppingAlert.shared.showAlert(self.viewModel?.model.userData?.reason ?? "")
                case .error(let error):
                    ShoppingAlert.shared.showAlert(error.localizedDescription)
                }
            }
            
        }
    }
    
    @IBAction func loginButtonTap() {
        Task { @MainActor in
            await viewModel?.fetchLogin(loginData: LoginModelEncodable(username: emailTextField.text ?? "", password: passwordTextField.text ?? ""))
        }
    }
}

