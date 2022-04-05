//
//  StubGenerator.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 31/03/22.
//

import Foundation
class StubGenerator {
    static func stubNews() throws -> [News] {
        guard  let path = Bundle.main.path(forResource: "NewsData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let newsDict = try decoder.decode(ServerResponse.self, from: data)
            return newsDict.newsArray
        } catch {
            throw APIError.unknown
        }
    }
    
    static func stubResponseData() throws -> Data {
        guard  let path = Bundle.main.path(forResource: "NewsData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw APIError.unknown
        }
    }
}
