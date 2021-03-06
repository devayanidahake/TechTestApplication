//
//  NewsDetailViewControllerTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 31/03/22.
//

import Foundation
import XCTest

@testable import TechTestApplication

class NewsDetailViewControllerTest: XCTestCase {
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testIsNavigationTitleCorrect() {
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let newsView = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardXIBNames.newsDetailViewController)as? NewsDetailViewController
        let _ = newsView?.view
        XCTAssertEqual(newsView?.navigationItem.title, Constants.Texts.newsDetailTitle)
    }
    
    func testICreateDetailViewObjectWithViewModel() {
        // Given
        let vm = NewsDetailViewModel(newsURL: Constants.URLs.baseURL)
        let expect = XCTestExpectation(description: "detail screen object is created")
        // When
        let newsDetailView = NewsDetailViewController.create(model: vm)
        expect.fulfill()
        // Then
        XCTAssertNotNil(newsDetailView)
        wait(for: [expect], timeout: 3.0)
    }
}
