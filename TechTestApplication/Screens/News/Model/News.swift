//
//  News.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

// MARK: - News
struct News: Codable, Equatable {
    var author: String
    var title: String
    var date: String
    var url: String
    var imageUrl: String

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case date
        case url
        case imageUrl
    }
}
