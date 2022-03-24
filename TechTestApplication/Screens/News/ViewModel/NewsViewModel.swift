//
//  NewsViewModel.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

class NewsViewModel{
    
    private var newsDataService: NewsDataServiceProtocol
    var reloadTableView: (() -> Void)?
    
    init(newsDataService: NewsDataServiceProtocol = NewasDataService()) {
        self.newsDataService = newsDataService
    }
}
