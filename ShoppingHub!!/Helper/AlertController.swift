//
//  AlertController.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 23/01/24.
//

import Foundation
import UIKit

final class ShoppingAlert {
    
    private init(){}
    
    static let shared = ShoppingAlert()
    
    var shoppingAlert: UIAlertController!
    
    func showAlert(_ message: String?, _ title: String? = nil ){
        
        shoppingAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            print("Tap OK")
        }
        shoppingAlert.addAction(action)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        guard let rootVC = window?.rootViewController else {
            return
        }
        rootVC.present(shoppingAlert, animated: true)
    }
}
