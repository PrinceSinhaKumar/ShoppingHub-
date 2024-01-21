//
//  AppFontHelper.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit

protocol FontFamily {
    var value: AppFont.Weight { get }
}

typealias AppFont = UIFont

protocol FontManager {
    static func font(with size: CGFloat, family: FontFamily?) -> AppFont
}

extension AppFont: FontManager {
    static func font(with size: CGFloat, family: FontFamily?) -> AppFont {
        return UIFont.systemFont(ofSize: size, weight: family?.value ?? .regular)
    }
}

enum OpenSans: FontFamily {
    case regular
    case bold
    case medium
    case light
    case semiBold
    case extraBold
    var value: AppFont.Weight {
        switch self {
        case .regular: return .regular
        case .bold: return .bold
        case .medium: return .medium
        case .light: return .light
        case .semiBold: return .semibold
        case .extraBold: return .heavy
        }
    }
}
