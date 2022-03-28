//
//  NewsDetailViewModel.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
protocol NewsDetailViewModelProtocol: AnyObject {
    //Properties
    var newsURL: String { get }
    
}

final class NewsDetailViewModel : NewsDetailViewModelProtocol {
    var newsURL = ""{
        didSet{
            reloadWebView?()
        }
    }
    
    var reloadWebView: (() -> Void)?

    
    required init(newsURLvalue : String) {
        self.newsURL = newsURLvalue
    }
    
    
    
    
}
