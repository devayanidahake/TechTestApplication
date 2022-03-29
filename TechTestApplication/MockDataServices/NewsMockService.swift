//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation


class NewsMockDataService: NewsDataServiceProtocol {
    
    func getNewsData(api: NewsApi) async throws -> NewsArray {
        if api == .invalid {
            throw APIError.unknown
        }
        do {
            let newsArray = try StubGenerator.stubNews()
            return newsArray
            
        }
        catch{
            throw error
        }
    }
    
}

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
            
            let newsDict = try decoder.decode(NewsDict.self, from: data)
            return newsDict.newsArray
        }
        catch{
            throw APIError.unknown
        }
    }
}
