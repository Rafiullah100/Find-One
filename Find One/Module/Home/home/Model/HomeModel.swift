//
//  HomeModel.swift
//  Find One
//
//  Created by MacBook Pro on 2/26/24.
//

import Foundation

struct CitiesModel: Codable {
    let success: Bool?
    let result: [CitiesResult]?
    let message: String?
}

// MARK: - Result
struct CitiesResult: Codable {
    let id: Int?
    let name, slug, imageURL: String?
    let instituteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageURL = "image_url"
        case instituteCount = "institute_count"
    }
}


struct RegionModel: Codable {
    let success: Bool?
    let result: [RegionResult]?
    let message: String?
}

// MARK: - Result
struct RegionResult: Codable {
    let id, countryID: Int?
    let name, slug, imageURL: String?
    let instituteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case name, slug
        case imageURL = "image_url"
        case instituteCount = "institute_count"
    }
}


struct sustainableModel: Codable {
    let success: Bool?
    let result: [sustainableResult]?
    let message: String?
}

// MARK: - Result
struct sustainableResult: Codable {
    let id: Int?
    let name, imageURL: String?
    let sustainable: Int?
    let slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case sustainable
        case slug
    }
}


struct InstituteModel: Codable {
    let success: Bool?
    let result: [InstituteResult]?
    let message: String?
}

// MARK: - Result
struct InstituteResult: Codable {
    let id: Int?
    let name: String?
}


struct FeatureModel: Codable {
    let success: Bool?
    let result: [FeatureResult]?
    let message: String?
}

// MARK: - Result
struct FeatureResult: Codable {
    let id: Int?
    let name, imageURL: String?
    let gender: String?
    let slug: String?
    let reviewsAvg: String?
    let fee: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case gender
        case slug
        case reviewsAvg = "reviews_avg"
        case fee
    }
}

