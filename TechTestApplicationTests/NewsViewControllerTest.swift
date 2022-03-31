//
//  NewsViewControllerTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 31/03/22.
//

import Foundation
import XCTest

@testable import TechTestApplication

class NewsViewControllerTest: XCTestCase {
    
    var sut: NewsViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        let mockAPIService = NewsMockDataService()
        sut = NewsViewModel(newsDataService: mockAPIService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testIsNavigationTitleCorrect() {
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let newsView = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardXIBNames.newsViewController)as? NewsViewController
        let _ = newsView?.view
        XCTAssertEqual(newsView?.navigationItem.title, "News")
    }

}
