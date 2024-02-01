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
    let gradientColors = [AppColor.AppOrange.color!, AppColor.AppOrange.color!]
    
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
    
    func fetchMealsData(complition: @escaping () -> ()){
        eventHandler?(.loading)
        ReloadFoodModel().fetchFoodList {[weak self] _, error in
            self?.eventHandler?(.stopLoading)
            guard error == nil else {
                self?.eventHandler?(.error(error?.errorMessage ?? ""))
                return
            }
            complition()
        }
    }
}
