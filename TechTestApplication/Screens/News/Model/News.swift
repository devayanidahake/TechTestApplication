//
//  News.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
typealias NewsArray = [News]

struct NewsDict: Codable{
    let category: String
    let newsArray: NewsArray

    enum CodingKeys: String, CodingKey {
        case category
        case newsArray = "data"
    }
}

// MARK: - News
struct News: Codable, Equatable {
    let author: String
    let title: String
    let date: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case date
        case url
    }
}
