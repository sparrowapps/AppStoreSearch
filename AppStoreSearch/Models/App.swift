//
//  App.swift
//  AppStoreSearch
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import Foundation


struct AppResponse: Decodable {
    var resultCount: Int
    var results: [App]
}

struct App: Decodable {
    var name: String
    var genre: String
    var icon: String
    var screenshots: [String]
    var description: String
    let artistName: String
    let averageUserRating: Double?
    let version: String
    let releaseNotes: String?
    let sellerName: String
    let fileSizeBytes: String
    let trackContentRating: String
    
    let trackID: Int
    let artistID: Int
    
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    
    var media: [String] {
        var images = screenshots
        images.insert(icon, at: 0)
        return images
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case genre = "primaryGenreName"
        case icon = "artworkUrl512"
        case screenshots = "screenshotUrls"
        case averageUserRatingForCurrentVersion
        case userRatingCountForCurrentVersion
        case description
        case artistName
        case averageUserRating
        case version
        case releaseNotes
        case sellerName
        case fileSizeBytes
        case trackContentRating
        case trackID = "trackId"
        case artistID = "artistId"
    }
}
