//
//  Color.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//


import Foundation
import UIKit
enum CustomColor: String {
    case appColor = "appColor"
    case tabTextColor = "tabTextColor"
    case shadowColor = "shadowColor"
    case tabBGColor = "tabBGColor"
    case appSecondryColor = "appSecondryColor"
    case borderColor = "borderColor"
    case navigationColor = "navigationColor"
    case tabbarTextColor = "tabbarTextColor"
    case blueishColor = "blueishColor"
    case buttonColor = "buttonColor"
}

extension CustomColor {
    var color: UIColor {
        switch self {
        case .appColor:
            return UIColor(hex: 0x72B54D, alpha: 1.0)
        case .tabTextColor:
            return UIColor(hex: 0xBCBCBC, alpha: 0.6)
        case .shadowColor:
            return UIColor(hex: 0xE33333, alpha: 0.4)
        case .tabBGColor:
            return UIColor(hex: 0xF7F7F7, alpha: 1.0)
        case .appSecondryColor:
            return UIColor(hex: 0x0635AD, alpha: 1.0)
        case .borderColor:
            return UIColor(hex: 0xCCCCCC, alpha: 1.0)
        case .navigationColor:
            return UIColor(hex: 0xCCCCCC, alpha: 0.1)
        case .tabbarTextColor:
            return UIColor(hex: 0xBBBBBB, alpha: 0.1)
        case .blueishColor:
            return UIColor(hex: 0x002ED1, alpha: 0.1)
        case .buttonColor:
            return UIColor(hex: 0xF3F3F3, alpha: 0.1)
        }
    }
    
    
    static func uiColor(_ color: CustomColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? .clear
    }
}


