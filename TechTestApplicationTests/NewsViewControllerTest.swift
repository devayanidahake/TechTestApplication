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
        XCTAssertEqual(sut.navigationItem.title, "News")
    }
    
    func testIfTableViewCellGetsCreated() {
        // Given
        _ = sut.view
        guard let cell = sut.tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier) as? NewsCell
        else { fatalError(Constants.ErrorMessages.xibNotFound) }
        
        // cell  will be created with CellVM data
        //When
        let cellVM = NewsCellViewModel(author: "A", title: "J", date: "abcd ", imageUrl: "https://www.google.com")
        cell.cellViewModel = cellVM
        
        //Then
        XCTAssertNotNil(cell.cellViewModel?.title)
        XCTAssertEqual(cell.cellViewModel?.author, "A")
    }

}
