//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation


class NewsMockDataService: NewsDataServiceProtocol{
    
    func getNewsFromServer() async throws -> NewsArray {
        let newsArray = try StubGenerator.stubNews()
        return newsArray
    }
   
}

class StubGenerator {
    
    static func stubNews() throws -> [News] {
        let path = Bundle.main.path(forResource: "NewsContent", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
        let newsDict = try decoder.decode(NewsDict.self, from: data)
        return newsDict.newsArray
        }
        catch{
            throw APIError.unknown
        }
    }
}
