//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 30/01/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoItem]
}

struct VideoItem: Codable {
    let id: VideoElement
}

struct VideoElement: Codable {
    let kind: String
    let videoId: String
}
