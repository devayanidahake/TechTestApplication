//
//  ServerResponse.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 05/04/22.
//

import Foundation

struct ServerResponse: Codable {
    let category: String
    let newsArray: [News]

    enum CodingKeys: String, CodingKey {
        case category
        case newsArray = "data"
    }
}
