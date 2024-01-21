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
    case error(Error)
}

typealias Handler = (Decodable?, Error?) -> ()

class LoginModel {
  
    var userData: LoginModelDecodable?
    
    func fetchLoginService(loginData: Encodable,completion: @escaping Handler) async{
        do {
            userData = try await ApiManager.shared.sendData(from: .getLoginContent, with: loginData)
            completion(userData, nil)
        } catch {
           completion(nil, error)
        }
    }
    
}
