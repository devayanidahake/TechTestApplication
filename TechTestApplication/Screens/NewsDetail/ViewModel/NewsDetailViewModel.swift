//
//  NewsDetailViewModel.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation

protocol NewsDetailViewModelProtocol: AnyObject {
    
    func fetchWebViewURLToLoad() throws -> URL
    
}

final class NewsDetailViewModel : NewsDetailViewModelProtocol {
    
    //MARK: Properties
    var newsDetailURL: String
    
    required init(newsURL : String) {
        self.newsDetailURL = newsURL
    }
    
    //MARK: Methods
    func fetchWebViewURLToLoad() throws -> URL  {
        guard let webViewURL = URL.init(string: newsDetailURL) else {
            throw APIError.invalidURL
        }
        return webViewURL
    }
}
