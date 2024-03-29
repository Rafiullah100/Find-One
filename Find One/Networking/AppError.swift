//
//  AppError.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError
    case noInternet
    
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrl:
            return "HEYYY!!! Give me a valid URL"
        case .serverError:
            return "Couldn't connect to server."
        case .noInternet:
            return "You're currently offline. Please connect with Wifi and try again later."
        }
    }
}
