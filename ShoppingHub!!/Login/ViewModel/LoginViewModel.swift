//
//  LoginViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit

class LoginViewModel {
    
    let model: LoginModel
    var eventHandler: ((_ events: Event) -> Void)?
    let gradientColors = [
        UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1),
        UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1)
    ]
    
    init(model: LoginModel) {
        self.model = model
    }
    
    func fetchLogin(loginData: Encodable){
        eventHandler?(.loading)
         model.fetchLoginService(loginData: loginData) { [weak self] data, error in
            self?.eventHandler?(.stopLoading)
            guard  error == nil else {
                self?.eventHandler!(.error(error?.errorMessage ?? ""))
                return
            }
            if let data = data {
                self?.eventHandler?(.dataLoaded)
            }
        }
    }
}
