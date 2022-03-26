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
    var showNetworkError: ((NetworkError) -> Void)?

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
    
    var serverError: NetworkError = .noError {
        didSet{
            showNetworkError?(serverError)
        }
    }

    
    init(newsDataService: NewsDataServiceProtocol = NewasDataService()) {
        self.newsDataService = newsDataService
    }
    
    func getNewsArray() {
        self.isDataLoading = true
        newsDataService.getNews { success, results, networkError in
            self.isDataLoading = false

            if let error = networkError {
                //ToDO:
                self.serverError = error
                return
            }

            if success, let newsResults = results {
                self.fetchData(news: newsResults)
                self.isDataLoading = false
            }
        }
    }
    
    func fetchData(news: NewsArray) {
        self.newsArray = news // To Do for unit testing
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
