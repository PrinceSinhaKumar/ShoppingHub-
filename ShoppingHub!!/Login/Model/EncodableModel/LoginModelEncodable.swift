//
//  LoginModelEncodable.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import Foundation

struct LoginModelEncodable: Encodable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
