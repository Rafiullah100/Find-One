//
//  ResultModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/5/24.
//

import Foundation

struct ResultModel: Codable {
    let success: Bool?
    let result: [Results]?
    let message: String?
}

// MARK: - Result
struct Results: Codable {
    let id: Int?
    let name, slug, imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageURL = "image_url"
    }
}



//////////

struct SearchModel: Codable {
    let success: Bool?
    let result: [SearchResult]?
    let message: String?
}

// MARK: - Result
struct SearchResult: Codable {
    let id: Int?
    let name: String?
    let latitude, longitude: Double?
    let imageURL: String?
    let country: String?
    let region: String?
    let city: String?
    let type: String?
    let curriculam: String?
    let educationLevel: String?
    let gender: String?
    let reviewsAvg: String?
    let instituteFacility: [SearchInstituteFacility]?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude
        case imageURL = "image_url"
        case country, region, city, type, curriculam
        case educationLevel = "education_level"
        case gender
        case reviewsAvg = "reviews_avg"
        case instituteFacility = "institute_facility"
    }
}

// MARK: - InstituteFacility
struct SearchInstituteFacility: Codable {
    let id: Int?
    let facility: SearchFacility?
}

// MARK: - Facility
struct SearchFacility: Codable {
    let id: Int?
    let image: String?
    let facilityDescriptions: [SearchFacilityDescription]?

    enum CodingKeys: String, CodingKey {
        case id, image
        case facilityDescriptions = "facility_descriptions"
    }
}

// MARK: - FacilityDescription
struct SearchFacilityDescription: Codable {
    let id: Int?
    let name: String?
}
