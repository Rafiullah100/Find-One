//
//  Storyboard.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import UIKit

enum Storyboard: String {
    case auth = "Auth"
    case home = "Home"
    case menu = "Menu"
    case result = "Result"
    case profile = "Profile"

    func instantiate<T>(identifier: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("No such view controller found")
        }
        return viewcontroller
    }
}
