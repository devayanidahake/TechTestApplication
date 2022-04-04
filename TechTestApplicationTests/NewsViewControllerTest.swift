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
    
    var sut: NewsViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let newsView = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardXIBNames.newsViewController)as? NewsViewController
        sut = newsView
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testIsNavigationTitleCorrect() {
        let _ = sut.view
        XCTAssertEqual(sut.navigationItem.title, Constants.Texts.newsListTitle)
    }
}
