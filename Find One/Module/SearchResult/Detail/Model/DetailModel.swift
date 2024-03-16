//
//  DetailModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/5/24.
//

import Foundation

struct DetailModel: Codable {
    let success: Bool?
    let result: DetailResult?
    let message: String?
}

// MARK: - Result
struct DetailResult: Codable {
    let id: Int?
    let name: String?
    let monthlyViews, digitalPresence, happyExperince: Int?
    let detail, address: String?
    let latitude, longitude: Double?
    let imageURL, country, region, city: String?
    let type, curriculam, educationLevel, gender: String?
    let instituteShifts: [InstituteShift]?
    let instituteFacility: [InstituteFacility]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case monthlyViews = "monthly_views"
        case digitalPresence = "digital_presence"
        case happyExperince = "happy_experince"
        case detail, address, latitude, longitude
        case imageURL = "image_url"
        case country, region, city, type, curriculam
        case educationLevel = "education_level"
        case gender
        case instituteShifts = "institute_shifts"
        case instituteFacility = "institute_facility"
    }
}

// MARK: - InstituteFacility
struct InstituteFacility: Codable {
    let id: Int?
    let name, icon: String?
}

// MARK: - InstituteShift
struct InstituteShift: Codable {
    let id: Int?
    let name, fromTime, toTime: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case fromTime = "from_time"
        case toTime = "to_time"
    }
}


struct FeeStructureModel: Codable {
    let success: Bool?
    let message: String?
    let result: [FeeResult]?
}

// MARK: - Result
struct FeeResult: Codable {
    let id: Int?
    let name: String?
    let fee: Int?
}

struct GalleryModel: Codable {
    let success: Bool?
    let message: String?
    let result: [GalleryResult]?
}

// MARK: - Result
struct GalleryResult: Codable {
    let id: Int?
    let images, title: String?
}


struct LocationModel: Codable {
    let success: Bool?
    let message: String?
    let result: LocationResult?
}

// MARK: - Result
struct LocationResult: Codable {
    let id: Int?
    let name, slug: String?
    let latitude, longitude: Double?
    let address, image: String?
}


struct ReviewModel: Codable {
    let success: Bool?
    let message: String?
    let result: [ReviewResult]?
}

// MARK: - Result
struct ReviewResult: Codable {
    let id, userID, instituteID, rating: Int?
    let reviewText: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?
    let user: ReviewUser?
    let institute: ReviewInstitute?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case instituteID = "institute_id"
        case rating
        case reviewText = "review_text"
        case isDeleted, createdAt, updatedAt, user, institute
    }
}

// MARK: - Institute
struct ReviewInstitute: Codable {
    let id: Int?
    let name, slug, image: String?
}

// MARK: - User
struct ReviewUser: Codable {
    let id: Int?
    let name, username, profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case profileImage = "profile_image"
    }
}


struct AddReviewModel: Codable {
    let success: Bool?
    let result: AddReviewResult?
    let message: String?
}

// MARK: - Result
struct AddReviewResult: Codable {
    let isDeleted, id, instituteID, userID: Int?
    let rating: Int?
    let reviewText, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted, id
        case instituteID = "institute_id"
        case userID = "user_id"
        case rating
        case reviewText = "review_text"
        case updatedAt, createdAt
    }
}


struct ReviewInoutModel {
    let review: String?
    let rating: Int?
    let id: Int?
}
