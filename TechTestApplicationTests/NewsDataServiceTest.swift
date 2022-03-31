//
//  NewsDataServiceTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 30/03/22.
//

import XCTest
@testable import TechTestApplication

class NewsDataServiceTest: XCTestCase {
    var sut: NewsDataService!
    
    override func setUpWithError() throws {
        super.setUp()
        let mockNetworkManager = MockNetworkManager()
        sut = NewsDataService(withNetworkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testGetNewsDataFunctionForSuccessResponse() {
        let expect = XCTestExpectation(description: "detail screen will be shown with news url")

        Task{[weak self] in
            let data = try await self?.sut?.getNewsData(api:.list)
            expect.fulfill()
            DispatchQueue.main.async {
                XCTAssertNotNil(data)
            }
            wait(for: [expect], timeout: 8.0)
        }
    }
    
    func testGetNewsDataFunctionForErrorResponse() {
        Task{
            do{
                let _ = try await sut.getNewsData(api:.invalid)
            }
            catch{
                XCTAssertNotNil(error)
            }
        }
    }
}
