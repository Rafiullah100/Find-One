//
//  SuccessModel.swift
//  Find One
//
//  Created by MacBook Pro on 2/23/24.
//

import Foundation

struct SuccessModel: Codable {
//    let success: Int?
    let message: String?
}

struct SignupInputModel {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
    
    let mobile: String
}

struct ValidationResponse {
    let isValid: Bool
    let message: String
}

struct LoginInputModel {
    let email: String
    let password: String
}


struct SignupModel: Codable {
    let success: Bool?
    let message: String?
}
