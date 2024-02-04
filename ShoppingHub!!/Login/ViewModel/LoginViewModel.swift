//
//  LoginViewModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit

class LoginViewModel {
    
    let model: LoginModelDelegate
    let reloadFoodModel: ReloadFoodModelDelegate
    var eventHandler: ((_ events: Event) -> Void)?
    let gradientColors = [AppColor.AppOrange.color!, AppColor.AppOrange.color!]
    
    init(model: LoginModelDelegate, reloadFoodModel: ReloadFoodModelDelegate) {
        self.model = model
        self.reloadFoodModel = reloadFoodModel
    }
    
    func fetchLogin(loginData: Encodable){
        eventHandler?(.loading)
         model.fetchLoginService(loginData: loginData) { [weak self] _, error in
            self?.eventHandler?(.stopLoading)
            guard  error == nil else {
                self?.eventHandler!(.error(error?.errorMessage ?? ""))
                return
            }
            self?.eventHandler?(.dataLoaded)
        }
    }
    
    func fetchMealsData(complition: @escaping () -> ()){
        eventHandler?(.loading)
        reloadFoodModel.fetchFoodList {[weak self] _, error in
            self?.eventHandler?(.stopLoading)
            guard error == nil else {
                self?.eventHandler?(.error(error?.errorMessage ?? ""))
                return
            }
            complition()
        }
    }
}
