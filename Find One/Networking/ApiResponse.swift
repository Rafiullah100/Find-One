//
//  ApiResponse.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}



