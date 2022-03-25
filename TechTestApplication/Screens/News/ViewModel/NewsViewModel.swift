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
    var showAnimator: ((Bool) -> Void)?

    var newsArray = NewsArray()
    var isDataLoading: Bool = true {
        didSet{
            showAnimator?(isDataLoading)
        }
    }
    
    var newsCellViewModels = [NewsCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    
    init(newsDataService: NewsDataServiceProtocol = NewasDataService()) {
        self.newsDataService = newsDataService
    }
    
    func getNewsArray() {
        self.isDataLoading = true
        newsDataService.getNews { success, results, error in
            if success, let newsResults = results {
                self.fetchData(news: newsResults)
                self.isDataLoading = false
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(news: NewsArray) {
        self.newsArray = news // Cache
        var cellModels = [NewsCellViewModel]()
        for newsObject in newsArray {
            cellModels.append(createCellModel(news: newsObject))
        }
        self.newsCellViewModels = cellModels
    }
    
    func createCellModel(news: News) -> NewsCellViewModel {
        let newsAuthor = news.author
        let newsTitle = news.title
        let newsDate = news.date
        
        return NewsCellViewModel(author: newsAuthor, title: newsTitle, date: newsDate)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> NewsCellViewModel {
        return newsCellViewModels[indexPath.row]
    }
}
