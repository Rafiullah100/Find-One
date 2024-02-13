//
//  Route.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation

enum Route {
    static let baseUrl = "https://admin.qaaren.com/"
    case signup
    
    var description: String {
        switch self {
        case .signup:
            return "mobile/auth/registers"
        }
    }
}
