//
//  SearchModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/8/24.
//

import Foundation

struct SearchRegionModel: Codable {
    let success: Bool?
    let result: [RegionResultModel]?
    let message: String?
}

// MARK: - Result
struct RegionResultModel: Codable {
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


struct SearchCityModel: Codable {
    let success: Bool?
    let result: [CityResultModel]?
    let message: String?
}

// MARK: - Result
struct CityResultModel: Codable {
    let id: Int?
    let name, slug, imageURL: String?
    let instituteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageURL = "image_url"
        case instituteCount = "institute_count"
    }
}


struct InstitutetypeModel: Codable {
    let success: Bool?
    let result: [InstitutetypeResult]?
    let message: String?
}

// MARK: - Result
struct InstitutetypeResult: Codable {
    let id: Int?
    let name: String?
}


struct GenderModel: Codable {
    let success: Bool?
    let result: [GenderResult]?
    let message: String?
}

// MARK: - Result
struct GenderResult: Codable, Equatable {
    let id: Int?
    let name: String?
}
