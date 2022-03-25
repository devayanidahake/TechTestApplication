//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
protocol NewsDataServiceProtocol {
    func getNews(completion: @escaping (_ success: Bool, _ results: NewsArray?, _ error: String?) -> ())
    
}
struct URLConstants {
    static let newsURL = "https://inshortsapi.vercel.app/news?category=science"
}

class NewasDataService: NewsDataServiceProtocol {
    func getNews(completion: @escaping (Bool, NewsArray?, String?) -> ()) {
       
        NetworkManager.shared.GET(url: URLConstants.newsURL, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
            do {
                let model = try JSONDecoder().decode(NewsDict.self, from: data!)
                completion(true, model.newsArray, nil)
            } catch {
                completion(false, nil, "Error: Trying to parse News to model")
            }
        } else {
            completion(false, nil, "Error: Employees GET Request failed")
        }
    }
    }
    
 
}
