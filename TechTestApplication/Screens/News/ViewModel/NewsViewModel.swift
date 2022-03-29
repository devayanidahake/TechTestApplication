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
    var navigateToNewsDetailView: ((String) -> Void)? { get  set}
    var newsArray: NewsArray { get }
    
    func getNewsArray()
    func getCellViewModel(at indexPath: IndexPath) -> NewsCellViewModel
    func handleCellPressedAtIndex(index: Int)
    
}

final class NewsViewModel : NewsViewModelProtocol{
    
    
    //MARK: Properties
    var showAnimator: ((Bool) -> Void)?
    
    var reloadTableView: (() -> Void)?
    
    var showAPIError: ((APIError) -> Void)?
    
    var navigateToNewsDetailView: ((String) -> Void)?
    
    private var newsDataService: NewsDataServiceProtocol
    
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
        Task{
            do{
                if let newsResults = try await newsDataService.getNewsFromServer(){
                    self.isDataLoading = false
                    self.parseDataIntoModelsFromServerData(news: newsResults)
                }
            }
            catch let error as APIError
            {
                self.isDataLoading = false
                self.serverError = error
            }
            catch
            {
                self.isDataLoading = false
                self.serverError = APIError.unknown
            }
        }
    }
    
    
    private func parseDataIntoModelsFromServerData(news: NewsArray) {
        self.newsArray = news // To Do for unit testing
        
        var cellModels = [NewsCellViewModel]()
        for newsObject in newsArray {
            cellModels.append(createCellModel(news: newsObject))
        }
        self.newsCellViewModels = cellModels
    }
    
    private    func createCellModel(news: News) -> NewsCellViewModel {
        let newsAuthor = news.author
        let newsTitle = news.title
        let newsDate = news.date
        let newsImgUrl = news.imageUrl
        
        return NewsCellViewModel(author: newsAuthor, title: newsTitle, date: newsDate, imageUrl: newsImgUrl)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> NewsCellViewModel {
        return newsCellViewModels[indexPath.row]
    }
    
    func handleCellPressedAtIndex(index: Int){
        let rowNews = self.newsArray[index]
        navigateToNewsDetailView?(rowNews.url)
    }
}
