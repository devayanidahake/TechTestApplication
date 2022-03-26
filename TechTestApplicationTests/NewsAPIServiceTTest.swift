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
    
    func testapiGETMethod() {
        
        // Given A apiservice
        let sut = self.sut!
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        sut.getNewsFromServer { (success, news, error) in
            let newsArray = StubGenerator.stubNews()
            expect.fulfill()
            XCTAssertEqual( newsArray.count, 2)
            for newsobj in newsArray {
                XCTAssertNotNil(newsobj.author)
            }
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testapiGETMethodForFailure() {
        
        // Given A apiservice
        let sut = self.sut!
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        sut.getNewsFromServer { (success, news, error) in
            //THEN
            let newsArray: NewsArray? = nil
            let error = APIError.responseError
            expect.fulfill()
            
            XCTAssertEqual(newsArray, nil)
            XCTAssertNotNil(error)
        }
        wait(for: [expect], timeout: 3)
    }
    
    
}
