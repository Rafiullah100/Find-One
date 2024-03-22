//
//  ChangePasswordModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/22/24.
//

import Foundation

struct ChangePasswordModel: Codable {
    let success: Bool?
    let message: String?
}

struct ChangePasswordInputModel: Codable {
    let oldPassword: String
    
    let password: String
    let confrimpassword: String
}
