//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

protocol NewsDataServiceProtocol {
    func getNewsFromServer() async throws -> NewsArray
}

class NewsDataService: NewsDataServiceProtocol {
    
    func getNewsFromServer() async throws -> NewsArray
    {
        let completeURL = Constants.URLs.baseURL + Constants.URLs.newsListEndpoints
        
        do{
            let responseData = try await NetworkManager.shared.apiGETMethod(url: completeURL)
            let newsDict = try JSONDecoder().decode(NewsDict.self, from: responseData)
            return newsDict.newsArray
        }
        catch
        {
            throw error
        }
        
    }
}
