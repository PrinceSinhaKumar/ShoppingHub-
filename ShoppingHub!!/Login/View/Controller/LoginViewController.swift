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
        viewModel = LoginViewModel(model: LoginModel())
        configureUI()
        configureObserver()
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
                case .dataLoaded: print(self.viewModel?.model.userData)
                case .error(let error): print(error.localizedDescription)
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
