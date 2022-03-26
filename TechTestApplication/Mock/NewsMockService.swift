//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation
//extension NewsDict {
//    static func getMockdata()-> NewsDict{
//        // Mock Data
//        let JSON = """
//        {"category":"science","data":[{"author":"Pragya Swastik","content":"Microplastics have been found in the human blood for the first time following a study that detected microplastics in 77% of the people tested. PET plastic, most commonly used to produce bottles, food packaging and clothes, was the most prevalent form of plastic found in human blood. The scientists tested the blood of 22 people for five types of plastic.","date":"24 Mar 2022,Thursday","imageUrl":"https://static.inshorts.com/inshorts/images/v1/variants/jpg/m/2022/03_mar/24_thu/img_1648130132507_32.jpg?","readMoreUrl":"https://www.independent.co.uk/climate-change/news/microplastics-human-blood-pollution-environment-b2043133.html?utm_campaign=fullarticle&utm_medium=referral&utm_source=inshorts ","time":"07:41 pm","title":"Microplastics found in human blood for the first time","url":"https://www.inshorts.com/en/news/microplastics-found-in-human-blood-for-the-first-time-1648131062646"},{"author":"Hiral Goyal","content":"Engineers at the Massachusetts Institute of Technology (MIT) have developed a fabric that can detect a wearer's subtle heartbeat. The fabric works like a microphone, converting sound into mechanical vibrations, then into electrical signals. It can detect sounds ranging in decibel from a quiet library to heavy road traffic. The fabric can also determine the precise direction of sudden sounds.","date":"19 Mar 2022,Saturday","imageUrl":"https://static.inshorts.com/inshorts/images/v1/variants/jpg/m/2022/03_mar/19_sat/img_1647707972603_835.jpg?","readMoreUrl":"https://www.timesnownews.com/viral/scientists-create-fabric-that-can-literally-hear-your-heartbeat-article-90310539/amp?utm_campaign=fullarticle&utm_medium=referral&utm_source=inshorts ","time":"10:39 pm","title":"Fabric that can 'hear' a person's heartbeat made by MIT engineers","url":"https://www.inshorts.com/en/news/fabric-that-can-hear-a-persons-heartbeat-made-by-mit-engineers-1647709785027"}]}
//        """
//
//        let jsonData = JSON.data(using: .utf8)!
//        let mockNewsDict: NewsDict = try! JSONDecoder().decode(NewsDict.self, from: jsonData)
//
//        return mockNewsDict
//
//    }
//}

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
    
    func getNews(completion: @escaping (Bool, NewsArray?, APIError?) -> ()) {
        isgetNewsCalled = true
        completeClosure = completion
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
