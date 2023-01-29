//
//  Movie.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
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

//struct TrendingMoviesResponse: Codable {
//    let movies: [Movie]
//
//    enum CodingKeys: String, CodingKey {
//        case movies = "results"
//    }
//}

//struct Movie: Codable {
//    let id: Int
//    let mediaType: String?
//    let originalName: String?
//    let originalTitle: String?
//    let posterPath: String?
//    let overview: String?
//    let voteCount: Int
//    let releaseDate: String?
//    let voteAverage: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case mediaType = "media_type"
//        case originalName = "original_name"
//        case originalTitle = "original_title"
//        case posterPath = "poster_path"
//        case overview = "overview"
//        case voteCount = "vote_count"
//        case releaseData = "release_date"
//        case voteAverage = "vote_average"
//    }
//}
