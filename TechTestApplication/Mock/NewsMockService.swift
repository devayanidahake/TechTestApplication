//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation


class NewsMockDataService: NewsDataServiceProtocol{
    
    var isgetNewsCalled = false
    
    var completeNews: [News] = [News]()
    var completeClosure: ((Bool, [News], APIError?) -> ())!
    
    
    func fetchSuccess() {
        completeClosure( true, completeNews, nil )
    }
    
    func fetchFail(error: APIError?) {
        completeClosure( false, completeNews, error )
    }
    
    func getNewsFromServer(completion: @escaping (Bool, NewsArray?, APIError?) -> ()) {
        isgetNewsCalled = true
        completeClosure = completion
    }
    
    func getNewsFromServer() async throws -> NewsArray {
        isgetNewsCalled = true
       //TODO: completeClosure = completion
        return NewsArray()
    }
    
    enum APIResponse: Error {
        case successWithData
        case successWithoutData
        case failure
        
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
