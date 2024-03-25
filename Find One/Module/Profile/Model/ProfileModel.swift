//
//  ProfileModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation
import UIKit
struct EditProfileInputModel {
    let name: String
    let email: String
    let mobile: String
    let image: UIImage?
    let about: String
    let city: String
    let country: String
    let gender: String
}

struct ProfileModel: Codable {
    let success: Bool?
    let user: UserProfile?
}

// MARK: - User
struct UserProfile: Codable {
    let lastLogin: String?
    let id: Int?
    let uuid, username, email, name: String?
    let about: String?
    let mobileNo: String?
    let profileImage: String?
    let profileImageThumb, backgroundImage, gender, country: String?
    let city: String?
    let isApproved: Int?
    let userType, registerFrom: String?
    let isNotification: Bool?
    let token: String?
    let isActive: Int?

    enum CodingKeys: String, CodingKey {
        case lastLogin = "last_login"
        case id, uuid, username, email, name, about
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case backgroundImage = "background_image"
        case gender, country, city
        case isApproved = "is_approved"
        case userType = "user_type"
        case registerFrom = "register_from"
        case isNotification = "is_notification"
        case token
        case isActive = "is_active"
    }
}

struct EditProfileModel: Codable {
    let success: Bool?
    let message: String?
}


struct DeleteModel: Codable {
    let success: Bool?
    let message: String?
}
