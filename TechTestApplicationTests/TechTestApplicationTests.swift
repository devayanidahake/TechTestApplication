//
//  TechTestApplicationTests.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 24/03/22.
//

import XCTest
@testable import TechTestApplication

class TechTestApplicationTests: XCTestCase {
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
    
    func test_loading_when_fetching() {
            
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
    
    func test_create_cell_view_model() {
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

}
