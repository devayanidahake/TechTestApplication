//
//  NewsCellViewModelTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 29/03/22.
//

import Foundation
import XCTest
@testable import TechTestApplication

class NewsDetailViewModelTest: XCTestCase {
    var sut: NewsDetailViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = NewsDetailViewModel(newsURL: "")
    }
    
    func testIfWebViewURLCreationSucceed() {
        // Given
        let expect = XCTestExpectation(description: "Web view url is correct")
        let urlString = "https://www.google.com"
        sut.newsDetailURL = urlString
        var webViewURL: URL? = nil
        
        do{
        let Url = try sut.fetchWebViewURLToLoad()
            webViewURL = Url
            expect.fulfill()
        }
        catch{
            
        }
        
        // WHEN
        
        wait(for: [expect], timeout: 3.0)

        // Assert
        XCTAssertNotNil(webViewURL)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
}
