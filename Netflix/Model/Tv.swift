//
//  Tv.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import Foundation

struct TrendingTvsResponse: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_data: String?
    let vote_average: Double
}
