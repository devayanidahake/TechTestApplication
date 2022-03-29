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
    
   
    func testLoadingWhenFetchingNewsFromServer() {
        
        //Given
        let expect = XCTestExpectation(description: "Loading status updated")
        
        sut.shouldShowAnimator = { (showAnimator) in
            expect.fulfill()            
        }
        //when fetching
        Task{
            await self.sut.getNewsArray()
            self.sut?.isDataLoading = false
        }
        
        wait(for: [expect], timeout: 3.0)

        
        // Assert
        XCTAssertTrue(sut.isDataLoading)
        
    }
    
    func testCreateNewsCellViewModel() {
        // Given
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableView = { () in
            expect.fulfill()
        }
        
        // When
        Task{
            await self.sut.getNewsArray()
        }
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 5.0)

        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.newsCellViewModels.count, 2 )
        
        
        
    }
    
    func testShowErrorWhenNoNetwork() {
        // Given
        let expect = XCTestExpectation(description: "no network alert is shown")
        sut.showAPIError = { (error) in
            expect.fulfill()
        }
        
        // When
        Task{
            await self.sut.getNewsArray()
            sut.serverError = APIError.noNetwork
        }
        
        // XCTAssert error closure triggered
        wait(for: [expect], timeout: 3.0)
        
        // Server Error
        XCTAssertNotNil(sut.serverError)
        
    }
    
    
    
    
}
