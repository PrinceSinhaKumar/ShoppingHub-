//
//  LoginViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import Foundation

class LoginViewModel {
    
    let model: LoginModel
    var eventHandler: ((_ events: Event) -> Void)?
    
    init(model: LoginModel) {
        self.model = model
    }
    
    func fetchLogin(loginData: Encodable) async{
        eventHandler?(.loading)
        await model.fetchLoginService(loginData: loginData) { [weak self] data, error in
            self?.eventHandler?(.stopLoading)
            guard  error == nil else {
                self?.eventHandler?(.error(error!))
                return
            }
            if let data = data {
                self?.eventHandler?(.dataLoaded)
            }
        }
    }
}
