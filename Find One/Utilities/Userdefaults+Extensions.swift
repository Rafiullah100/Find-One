//
//  Userdefaults+Extensions.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation


extension UserDefaults{
    enum userdefaultsKey: String {
        case selectedLanguage
        case name
        case email
        case mobile
        case profileImage
        case uuid
        case token
        case isLogin
        case appleUserData
        case rememberMe
    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
        }
    }
    
    var name: String?  {
        get {
            value(forKey: userdefaultsKey.name.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.name.rawValue)
        }
    }
    
    var email: String?  {
        get {
            value(forKey: userdefaultsKey.email.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.email.rawValue)
        }
    }
    
    var mobile: String?  {
        get {
            value(forKey: userdefaultsKey.mobile.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.mobile.rawValue)
        }
    }
    
    var profileImage: String?  {
        get {
            value(forKey: userdefaultsKey.profileImage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.profileImage.rawValue)
        }
    }
    
    var token: String?  {
        get {
            value(forKey: userdefaultsKey.token.rawValue) as? String
        }
        set {
            print(newValue)
            set(newValue, forKey: userdefaultsKey.token.rawValue)
        }
    }
    
    var uuid: String?  {
        get {
            value(forKey: userdefaultsKey.uuid.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.uuid.rawValue)
        }
    }
    
    var isLogin: Bool?  {
        get {
            value(forKey: userdefaultsKey.isLogin.rawValue) as? Bool
        }
        set {
            set(newValue, forKey: userdefaultsKey.isLogin.rawValue)
        }
    }
    
    var appleUserData: Data?{
        get {
            data(forKey: userdefaultsKey.appleUserData.rawValue)
        }
        set{
            set(newValue, forKey: userdefaultsKey.appleUserData.rawValue)
        }
    }
    
    var rememberMe: Bool?  {
        get {
            value(forKey: userdefaultsKey.rememberMe.rawValue) as? Bool
        }
        set {
            set(newValue, forKey: userdefaultsKey.rememberMe.rawValue)
        }
    }
}


extension UserDefaults {
    class func clean(exceptKeys keysToKeep: [String] = []) {
        guard let aValidIdentifier = Bundle.main.bundleIdentifier else { return }
        let defaults = UserDefaults.standard
        var valuesToKeep: [String: Any] = [:]
        for key in keysToKeep {
            if let value = defaults.value(forKey: key) {
                valuesToKeep[key] = value
            }
        }
        defaults.removePersistentDomain(forName: aValidIdentifier)
        for (key, value) in valuesToKeep {
            defaults.setValue(value, forKey: key)
        }
        defaults.synchronize()
    }
}
