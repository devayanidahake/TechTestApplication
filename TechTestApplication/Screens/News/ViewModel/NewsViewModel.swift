//
//  NewsViewModel.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    var reloadTableView: (() -> Void)? { get  set}
    var showAnimator: ((Bool) -> Void)? { get  set}
    var showAPIError: ((APIError) -> Void)? { get  set}
    var newsArray: NewsArray { get }
    var newsCellViewModels:[NewsCellViewModel] { get }
    
    func getNewsArray()
    func getCellViewModel(at indexPath: IndexPath) -> NewsCellViewModel
}

final class NewsViewModel : NewsViewModelProtocol{
    var showAnimator: ((Bool) -> Void)?
    
    var reloadTableView: (() -> Void)?
    
    var showAPIError: ((APIError) -> Void)?
    
    private var newsDataService: NewsDataServiceProtocol
    
    //MARK: Properties
    
    var newsArray = NewsArray()
    
    //Obeserved Properties
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
    
    var serverError: APIError = .noError {
        didSet{
            showAPIError?(serverError)
        }
    }

    //MARK: Methods
    init(newsDataService: NewsDataServiceProtocol = NewasDataService()) {
        self.newsDataService = newsDataService
    }
    
    func getNewsArray() {
        self.isDataLoading = true
        newsDataService.getNews { success, results, APIError in
            self.isDataLoading = false

            if let error = APIError {
                //ToDO:
                self.serverError = error
                return
            }

            if success, let newsResults = results {
                self.fetchData(news: newsResults)
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
