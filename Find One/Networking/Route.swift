//
//  Route.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation

enum Route {
    static let baseUrl = "https://find1-ap.nextgcircle.com/api/"
    case signup
    case login
    case appleLogin
    
    var description: String {
        switch self {
        case .signup:
            return "mobile/auth/register"
        case .login:
            return "mobile/auth/login"
        case .appleLogin:
            return "mobile/auth/apple-login"
        }
    }
}
