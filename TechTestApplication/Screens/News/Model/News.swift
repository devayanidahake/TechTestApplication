//
//  News.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
// MARK: - News
struct News: Codable {
    let id: String
    let author: String
    let title: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case title
        case date
    }
}
