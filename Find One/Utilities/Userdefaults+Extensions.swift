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

    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
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
