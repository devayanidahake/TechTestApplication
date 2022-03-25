//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
protocol NewsDataServiceProtocol {
    func getNews(completion: @escaping (_ success: Bool, _ results: NewsArray?, _ error: NetworkError?) -> ())
    
}
struct URLConstants {
    static let newsURL = "https://inshortsapi.vercel.app/news?category=science"
}

class NewasDataService: NewsDataServiceProtocol {
    func getNews(completion: @escaping (Bool, NewsArray?, NetworkError?) -> ()) {
       
        NetworkManager.shared.GET(url: URLConstants.newsURL, httpHeader: .application_json) { success, data, networkError in
            if success {
            do {
                let model = try JSONDecoder().decode(NewsDict.self, from: data!)
                completion(true, model.newsArray, nil)
            } catch {
                completion(false, nil, networkError)
            }
        } else {
            completion(false, nil,networkError)
        }
    }
    }
    
 
}
