//
//  ActivityIndicator.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 21/01/24.
//

import Foundation
import UIKit

final class ActivityIndicator {
    
    private init(){}
    
    public static let shared = ActivityIndicator()
    
    var activityIndicator:UIActivityIndicatorView!
    
    func startAnimating(with title: String? = ""){
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let vc = keyWindow.rootViewController else {
            return
        }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame =  CGRect(x: 0,
                                          y: 0,
                                          width: 100,
                                          height: 100)
        activityIndicator.color = UIColor(named: AppColor.AppWhiteSecond.rawValue)

        activityIndicator.startAnimating()
        activityIndicator.center = vc.view.center
        vc.view.addSubview(activityIndicator)
    }
    
    func stopAnimating(){
        activityIndicator.stopAnimating()
    }
}
