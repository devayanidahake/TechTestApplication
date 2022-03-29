//
//  NewsViewModelTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 26/03/22.
//

import XCTest
@testable import TechTestApplication

class NewsViewModelTest: XCTestCase {
    
    var sut: NewsViewModel! 
    
    override func setUpWithError() throws {
        super.setUp()
        let mockAPIService = NewsMockDataService()
        sut = NewsViewModel.init(newsDataService: mockAPIService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    
    func testGetNewsArrayFunctionForSuccessResponse() {
        
        // Given
        let expect = expectation(description: "API success")
        
        // When
        Task{
            await self.sut.getNewsArray()
            expect.fulfill()
        }
        
         waitForExpectations(timeout: 5)
                
        // Sut should display predefined news count
        XCTAssertEqual(sut.newsArray.count,2)
        for newsobj in sut.newsArray {
            XCTAssertNotNil(newsobj.author)
        }
    }
    
   
    func testGetNewsArrayFunctionForErrorResponse() {
        
        // Given
        let expect = expectation(description: "API failure")
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }
        
        // When
        Task{
            //do {
                await self.sut.getNewsArray
//            }
//            catch{
//                errorHandler(error)
//            }
            expect.fulfill()
        }
        
         waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(sut.serverError)
                
        // Sut should display predefined news count
//        if let error = thrownError {
////                    XCTFail(
////                        "Async error thrown: \(error)"
////                    )
//                }
        
        
        
    }
   /*
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
       // mockAPIService!.fetchSuccess()
        XCTAssertFalse( loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testCreateNewsCellViewModel() {
        // Given
        let news = StubGenerator.stubNews()
       // mockAPIService.serverResponseNews = news
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableView = { () in
            expect.fulfill()
        }
        
        // When
        sut.getNewsArray()
       // mockAPIService.fetchSuccess()
        
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
        //mockAPIService.fetchFail(error: .noNetwork)
        sut.serverError = mockAPIService.serverError
        
        // Server Error
        XCTAssertEqual( sut.serverError, APIError.noNetwork )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 3.0)
        
    }
    
    */
    
    
}
