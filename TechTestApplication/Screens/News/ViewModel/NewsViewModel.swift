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
    var showAPIError: ((Error) -> Void)? { get  set}
    var navigateToNewsDetailView: ((String) -> Void)? { get  set}
    var newsArray: NewsArray { get }
    
    func getNewsArray() async
    func getCellViewModel(at indexPath: IndexPath) -> NewsCellViewModel
    func handleCellPressedAtIndex(index: Int)
    
}

final class NewsViewModel : NewsViewModelProtocol {
    
    //MARK: Properties
    var showAnimator: ((Bool) -> Void)?
    
    var reloadTableView: (() -> Void)?
    
    var showAPIError: ((Error) -> Void)?
    
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
    
    var serverError: Error? {
        didSet{
            guard let serverError = serverError else {
                return
            }
            showAPIError?(serverError)
        }
    }
    
    //MARK: Methods
    init(newsDataService: NewsDataServiceProtocol) {
        self.newsDataService = newsDataService
    }
    
    func getNewsArray() async {
        self.isDataLoading = true
            do{
                let newsResults = try await newsDataService.getNewsData(api: .list)
                    self.isDataLoading = false
                    self.newsArray = newsResults
                    self.createNewsCellModels()
            }
            catch
            {
                self.isDataLoading = false
                self.serverError = error
            }
    }
    
    
    private func createNewsCellModels() {
        var cellModels = [NewsCellViewModel]()
        for newsObject in self.newsArray {
            cellModels.append(createCellModel(news: newsObject))
        }
        self.newsCellViewModels = cellModels
    }
    
    private func createCellModel(news: News) -> NewsCellViewModel {
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
