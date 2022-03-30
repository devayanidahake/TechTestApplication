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
        sut = NewsDataService.init(withNetworkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testGetNewsDataFunctionForSuccessResponse() {
        Task{
            do{
                let data = try await sut.getNewsData(api:.list)
                XCTAssertNotNil(data)
            }
            catch{
                XCTAssertNil(error)
            }

        }
    }
    
    func testGetNewsDataFunctionForErrorResponse() {
        Task{
            do{
                let _ = try await sut.getNewsData(api:.invalid)
            }
            catch{
                XCTAssertNotNil(error)
                XCTAssertIdentical(error as AnyObject, APIError.responseError as AnyObject)
            }

        }
    }
}
