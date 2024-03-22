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
    case institutesByCity
    case institutesByRegion
    case detail
    case detailRelated
    case region
    case city
    case curriculam
    case gender
    case search
    case addReview
    case grade
    case type
    case myProfile
    case updateProfile
    case changePassword
    case deleteAccount
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
        case .institutesByCity:
            return "mobile/home/institutes-by-city"
        case .institutesByRegion:
            return "mobile/home/institutes-by-region"
        case .detail:
            return "mobile/institutes/detail"
        case .detailRelated:
            return "mobile/institutes/detail-related"
        case .region:
            return "mobile/home/region"
        case .city:
            return "mobile/home/cities"
        case .curriculam:
            return "mobile/home/curriculam"
        case .gender:
            return "mobile/home/gender"
        case .search:
            return "mobile/search"
        case .addReview:
            return "mobile/institutes/add-review"
        case .grade:
            return "mobile/home/grade"
        case .type:
            return "mobile/home/type"
        case .myProfile:
            return "mobile/auth/me"
        case .updateProfile:
            return "mobile/user/profile-update"
        case .changePassword:
            return "mobile/user/password-update"
        case .deleteAccount:
            return "mobile/user/profile-delete"
        }
    }
}
