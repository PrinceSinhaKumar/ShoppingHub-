//
//  AppFontHelper.swift
//  ShoppingHub!!
//
//  Created by Priyanka Mathur on 20/01/24.
//

import UIKit
import SwiftUI

protocol FontFamily {
    var value: AppFont.Weight { get }
    var valueSUI: AppFontSUI.Weight { get }
}

typealias AppFont = UIFont
typealias AppFontSUI = Font

protocol FontManager {
}
extension FontManager {
    static func fontSUI(with size: CGFloat, family: FontFamily?) -> AppFontSUI { .title }
    static func font(with size: CGFloat, family: FontFamily?) -> AppFont { .systemFont(ofSize: 10) }

}

extension AppFont: FontManager {
    static func font(with size: CGFloat, family: FontFamily?) -> AppFont {
        return UIFont.systemFont(ofSize: size, weight: family?.value ?? .regular)
    }
}

extension AppFontSUI: FontManager {
    static func fontSUI(with size: CGFloat, family: FontFamily?) -> AppFontSUI {
        return Font.system(size: size, weight: family?.valueSUI)
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
    
    var valueSUI: AppFontSUI.Weight {
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
