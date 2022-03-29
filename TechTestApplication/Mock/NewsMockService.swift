//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation


class NewsMockDataService: NewsDataServiceProtocol{
    
    var isgetNewsCalled = false
    
    var serverResponseNews: [News] = [News]()
    
    var serverError: APIError = .noError
    
    func fetchSuccess() {
        serverResponseNews = StubGenerator.stubNews()
    }
    
    func fetchFail(error: APIError?) {
        serverError = error ?? .noError
    }
    
    func getNewsFromServer() async throws -> NewsArray? {
        isgetNewsCalled = true
       //TODO: completeClosure = completion
        
        return serverResponseNews
    }
}

class StubGenerator {
    static func stubNews() -> [News] {
        let path = Bundle.main.path(forResource: "NewsContent", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let newsDict = try! decoder.decode(NewsDict.self, from: data)
        return newsDict.newsArray
    }
}
