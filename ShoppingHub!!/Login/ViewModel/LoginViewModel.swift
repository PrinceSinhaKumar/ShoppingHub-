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
    
    func fetchLogin(loginData: Encodable) {
        let dispatchGroup = DispatchGroup()
        eventHandler?(.loading)
        dispatchGroup.enter()
        model.fetchLoginService(loginData: loginData) { [weak self] _, error in
            guard  error == nil else {
                self?.eventHandler!(.error(error?.errorMessage ?? ""))
                dispatchGroup.leave()
                return
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        reloadFoodModel.fetchFoodList {[weak self] _, error in
            self?.eventHandler?(.stopLoading)
            guard error == nil else {
                self?.eventHandler?(.error(error?.errorMessage ?? ""))
                dispatchGroup.leave()
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.eventHandler?(.dataLoaded)
        }
    }

}
