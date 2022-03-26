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


    
    func testGetNewsArrayForSuccess() throws {
        sut.getNewsArray()
        XCTAssertEqual( sut.newsArray, NewsDict.getMockdata().newsArray )

        
    }
    
    func testGetNewsArrayForFailure() throws {
        // Given a failed Network Error
        let error = NetworkError.responseError
        sut.getNewsArray()
        XCTAssertEqual(sut.serverError, error)

        
    }
    
    //API is successful but data is nil
    func testGetNewsArrayForSuccessWithoutData() throws {
        // Given a failed Network Error
        let error = NetworkError.responseError
        sut.getNewsArray()
        XCTAssertEqual(sut.serverError, error)

        
    }
    
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
