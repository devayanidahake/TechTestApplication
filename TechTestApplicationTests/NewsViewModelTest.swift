//
//  NewsViewModelTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 26/03/22.
//

import XCTest
@testable import TechTestApplication

class NewsViewModelTest: XCTestCase {
    var mockAPIService: NewsMockDataService!
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
    
    
    
    func testGetNews() {
        // Given
        mockAPIService.completeNews = [News]()
        
        // When
        sut.getNewsArray()
        
        // Assert
        XCTAssert(mockAPIService!.isgetNewsCalled)
    }
    
    
    func testGetNewsFail() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.responseError
        
        // When
        sut.getNewsArray()
        
        mockAPIService.fetchFail(error: error )
        
        // Sut should display predefined error message
        XCTAssertEqual( sut.serverError, error )
        
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
        mockAPIService.completeNews = news
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
        sut.serverError = .noNetwork
        let expect = XCTestExpectation(description: "rno network alert is shown")
        sut.showAPIError = { (error) in
            expect.fulfill()
        }
        
        // When
        sut.getNewsArray()
        mockAPIService.fetchFail(error: .noNetwork)
        
        // Server Error
        XCTAssertEqual( sut.serverError, APIError.noNetwork )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
}
