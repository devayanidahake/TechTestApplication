//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
protocol NewsDataServiceProtocol {
    func getNewsFromServer(completion: @escaping (_ success: Bool, _ results: NewsArray?, _ error: APIError?) -> ())
    func getNewsFromServer() async throws -> NewsArray
}

class NewasDataService: NewsDataServiceProtocol {
    func getNewsFromServer(completion: @escaping (Bool, NewsArray?, APIError?) -> ()) {
        let completeURL = Constants.URLs.baseURL + Constants.URLs.newsListEndpoints
        
        NetworkManager.shared.apiGETMethod(url: completeURL, httpHeader: .application_json) { success, data, APIError in
            if success {
                do {
                    let model = try JSONDecoder().decode(NewsDict.self, from: data!)
                    completion(true, model.newsArray, nil)
                }
                catch
                {
                    completion(false, nil, APIError)
                }
            }
            else {
                completion(false, nil,APIError)
            }
        }
    }
    
    func getNewsFromServer() async throws -> NewsArray
    {
        let completeURL = Constants.URLs.baseURL + Constants.URLs.newsListEndpoints
        
        do{
            let responseData = try await NetworkManager.shared.apiGETMethod(url: completeURL)
            let newsDict = try JSONDecoder().decode(NewsDict.self, from: responseData)
            return newsDict.newsArray
        }
        catch let error as APIError
        {
            throw error
        }
        catch
        {
            throw APIError.unknown
        }
    }
    
    
    
}
