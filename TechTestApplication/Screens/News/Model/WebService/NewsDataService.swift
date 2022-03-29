//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

enum NewsApi {
    case list
    case invalid
    
    var apiURL: String{
        switch self {
        case .list:
                return Constants.URLs.baseURL + Constants.URLs.newsListEndpoints
        case .invalid:
            return Constants.URLs.baseURL
    }
    
}
}

protocol NewsDataServiceProtocol {
    func getNewsData(api: NewsApi) async throws -> NewsArray
}

class NewsDataService: NewsDataServiceProtocol {
    
    
    func getNewsData(api: NewsApi) async throws -> NewsArray
    {
        do{
            let responseData = try await NetworkManager.shared.apiGETMethod(url: api.apiURL)
            let newsDict = try JSONDecoder().decode(NewsDict.self, from: responseData)
            return newsDict.newsArray
        }
        catch
        {
            throw error
        }
    }
}
