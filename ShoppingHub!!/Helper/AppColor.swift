//
//  AppColor.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 21/01/24.
//

import UIKit
import SwiftUI
enum AppColor: String {
    case AppWhite255
    case AppWhiteSecond
    case AppLightBlue
    case AppBlackTitle
    case AppOrange

    var color: UIColor? {
        return UIColor(named: self.rawValue)
    }
    
    var swiftUIColor: Color {
        return Color(self.rawValue)
    }
}
