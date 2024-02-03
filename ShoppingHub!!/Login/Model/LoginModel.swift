//
//  LoginModel.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import Foundation

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(String)
}

typealias Handler = (Decodable?, ErrorHandler?) -> ()

protocol LoginModelDelegate {
    var userData: LoginModelDecodable? { get }
    func fetchLoginService(loginData: Encodable, completion: @escaping Handler)
}

class LoginModel: LoginModelDelegate {
  
    var userData: LoginModelDecodable?
    
    func fetchLoginService(loginData: Encodable, completion: @escaping Handler){
        ApiManager.shared.sendData(from: .getLoginContent, with: loginData) { [weak self] result, error in
            self?.userData = result
            if let token = result?.token {
                UserDefaults.standard.set(token, forKey: uToken)
            }
            completion(result, error)
        }
    }
    
}
