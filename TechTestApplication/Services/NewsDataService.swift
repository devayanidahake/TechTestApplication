//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
protocol NewsDataServiceProtocol {
    func getNewsFromServer(completion: @escaping (_ success: Bool, _ results: NewsArray?, _ error: APIError?) -> ())
    
}
struct URLConstants {
    static let baseURL = "https://inshortsapi.vercel.app"
}

class NewasDataService: NewsDataServiceProtocol {
    func getNewsFromServer(completion: @escaping (Bool, NewsArray?, APIError?) -> ()) {
        let completeURL = URLConstants.baseURL + "/news?category=science"
        
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
    
    
}
