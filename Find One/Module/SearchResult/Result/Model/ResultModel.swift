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
