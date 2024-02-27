//
//  Route.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation

enum Route {
    static let imageBaseUrl = "https://find1-ap.nextgcircle.com/"
    static let baseUrl = "https://find1-ap.nextgcircle.com/api/"
    case signup
    case login
    case appleLogin
    case googleLogin
    case citiesList
    case regionList
    case sustainable
    case level
    case featureInstitute

    var description: String {
        switch self {
        case .signup:
            return "mobile/auth/register"
        case .login:
            return "mobile/auth/login"
        case .appleLogin:
            return "mobile/auth/apple-login"
        case .googleLogin:
            return "mobile/auth/google-login"
        case .citiesList:
            return "mobile/home/cities"
        case .regionList:
            return "mobile/home/region"
        case .sustainable:
            return "mobile/home/sustainable-institutes"
        case .level:
            return "mobile/home/level"
        case .featureInstitute:
            return "mobile/home/institutes-by-level?"
        }
    }
}
