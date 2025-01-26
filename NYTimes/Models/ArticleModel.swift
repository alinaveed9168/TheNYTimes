//
//  ArticleModel.swift
//  NYTimes
//
//  Created by ALI Naveed on 25/01/2025.
//

import Foundation

// MARK: - Welcome
struct Article: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

struct Result: Codable, Identifiable {
    var url: String?
    var id: Int?
    var publishedDate, updated: String?
    var media: [Media]?
    var byline: String?
    var titleArticle: String?

    enum CodingKeys: String, CodingKey {
        case url, id
        case publishedDate = "published_date"
        case updated
        case media
        case byline
        case titleArticle = "title"
    }
}

// MARK: - Media
struct Media: Codable {
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
    let format: Format
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

extension Result {
     
    static var dummyData: Result {
        .init(url: ""
        ,id: 324
        ,publishedDate: "2025-01-01"
        ,updated: "1234019"
        ,media: []
        ,byline: "Byline"
        ,titleArticle: "Article Title")
        
    }
}
