//
//  NewsViewModelTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 26/03/22.
//

import XCTest
@testable import TechTestApplication

class NewsViewModelTest: XCTestCase {
    var mockAPIService: NewsMockDataService! //= NewsMockDataService()
    
    var sut: NewsViewModel! 
    
    override func setUp() {
        super.setUp()
        mockAPIService = NewsMockDataService()
        sut = NewsViewModel.init(newsDataService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    
    
    func testGetNewsArrayFunctionIsGettingCalled() {
        // Given
        mockAPIService.serverResponseNews = [News]()
        
        // When
        sut.getNewsArray()
        
        // Assert
        XCTAssertTrue(mockAPIService!.isgetNewsCalled)
    }
    
    func testGetNewsArrayFunctionForSuccessResponse() {
        
        // Given
        mockAPIService.serverResponseNews = [News]()
        
        // When
        sut.getNewsArray()
        
        mockAPIService.fetchSuccess()
        sut.newsArray = mockAPIService.serverResponseNews
        
        // Sut should display predefined news count
        XCTAssertEqual( sut.newsArray.count, 2)
        for newsobj in sut.newsArray {
            XCTAssertNotNil(newsobj.author)
        }
    }
    
    func testGetNewsArrayFunctionForErrorResponse() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.responseError
        sut.serverError = error
        
        // When
        sut.getNewsArray()
        
        mockAPIService.fetchFail(error: error )
        
        
        // Sut should display predefined error message
        XCTAssertEqual(sut.serverError, error)
        
    }
    
    func testLoadingWhenFetchingNewsFromServer() {
        
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        
        sut.showAnimator = { (showAnimator) in
            loadingStatus = (self.sut!.isDataLoading)
            
            expect.fulfill()
            
        }
        expect.fulfill()
        //when fetching
        sut.getNewsArray()
        
        // Assert
        XCTAssertTrue(loadingStatus)
        
        // When finished fetching
        mockAPIService!.fetchSuccess()
        XCTAssertFalse( loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testCreateNewsCellViewModel() {
        // Given
        let news = StubGenerator.stubNews()
        mockAPIService.serverResponseNews = news
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableView = { () in
            expect.fulfill()
        }
        
        // When
        sut.getNewsArray()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.newsCellViewModels.count, news.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
    func testShowErrorWhenNoNetwork() {
        // Given
        let expect = XCTestExpectation(description: "no network alert is shown")
        sut.showAPIError = { (error) in
            expect.fulfill()
        }
        
        // When
        sut.getNewsArray()
        mockAPIService.fetchFail(error: .noNetwork)
        sut.serverError = mockAPIService.serverError
        
        // Server Error
        XCTAssertEqual( sut.serverError, APIError.noNetwork )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 3.0)
        
    }
    
    
    
    
}
