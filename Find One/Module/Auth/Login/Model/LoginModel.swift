//
//  LoginModel.swift
//  Find One
//
//  Created by MacBook Pro on 2/23/24.
//

import Foundation

struct LoginModel: Codable {
    let success: Bool?
    let message: String?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let lastLogin, createdAt, updatedAt: String?
    let id: Int?
    let roleID: Int?
    let uuid, username, password, email: String?
    let name: String?
    let about: String?
    let mobileNo: String?
    let profileImage: String?
    let profileImageThumb, backgroundImage, gender, country: String?
    let city: String?
    let isApproved: Int?
    let userType: String?
    let isNotification: Bool?
    let token: String?
    let isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case lastLogin = "last_login"
        case createdAt, updatedAt, id
        case roleID = "role_id"
        case uuid, username, password, email, name, about
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case backgroundImage = "background_image"
        case gender, country, city
        case isApproved = "is_approved"
        case userType = "user_type"
        case isNotification = "is_notification"
        case token
        case isActive = "is_active"
    }
}


struct AppleLoginModel: Codable {
    let success: Bool?
    let message, token: String?
    let userID: Int?
    let uuID, username, email, name: String?
    let mobileNo, profileImage: String?
    let profileImageThumb: String?
    let isActive: Bool?
    let about: String?

    enum CodingKeys: String, CodingKey {
        case success, message, token
        case userID = "userId"
        case uuID = "uuId"
        case username, email, name
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case isActive, about
    }
}


struct GoogleLoginModel: Codable {
    let success: Bool?
    let message: String?
    let user: GoogleUser?
}

// MARK: - User
struct GoogleUser: Codable {
    let lastLogin, createdAt, updatedAt: String?
    let id: Int?
    let roleID: Int?
    let uuid, username, password, email: String?
    let name: String?
    let about: String?
    let mobileNo: String?
    let profileImage: String?
    let profileImageThumb, backgroundImage, gender, country: String?
    let city: String?
    let isApproved: Int?
    let userType, provider, registerFrom: String?
    let isNotification: Bool?
    let token: String?
    let resetToken: String?
    let isActive: Bool?
    let status, isDeleted: Int?

    enum CodingKeys: String, CodingKey {
        case lastLogin = "last_login"
        case createdAt, updatedAt, id
        case roleID = "role_id"
        case uuid, username, password, email, name, about
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case backgroundImage = "background_image"
        case gender, country, city
        case isApproved = "is_approved"
        case userType = "user_type"
        case provider
        case registerFrom = "register_from"
        case isNotification = "is_notification"
        case token
        case resetToken = "reset_token"
        case isActive = "is_active"
        case status, isDeleted
    }
}
