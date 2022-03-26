//
//  NewsAPIServiceTTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 26/03/22.
//

import XCTest
@testable import TechTestApplication

class NewsAPIServiceTTest: XCTestCase {

        
        var sut: NewasDataService?
        
        override func setUp() {
            super.setUp()
            sut = NewasDataService()
        }

        override func tearDown() {
            sut = nil
            super.tearDown()
        }

        func testGetNews() {

            // Given A apiservice
            let sut = self.sut!

            // When fetch popular photo
            let expect = XCTestExpectation(description: "callback")
            sut.getNews { (success, news, error) in
                let newsArray = StubGenerator.stubNews()
                expect.fulfill()
                XCTAssertEqual( newsArray.count, 2)
                for newsobj in newsArray {
                    XCTAssertNotNil(newsobj.author)
                }
            }
            wait(for: [expect], timeout: 3.1)
        }
}
