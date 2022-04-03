//
//  NewsCellTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 03/04/22.
//

import Foundation
import XCTest

@testable import TechTestApplication

class NewsCellTest: XCTestCase {
    
    var sut: NewsCell!
    let tableView = UITableView()
    
    
    override func setUpWithError() throws {
        super.setUp()
        tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: IndexPath.init(row: 0, section: 0)) as? NewsCell
        else { fatalError(Constants.ErrorMessages.xibNotFound) }
        sut = cell
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testCellUpdateProperties() {
        // Given
        
        let vm = NewsCellViewModel(author: "Mike", title: "Big news", date: "23 March 2020 ", imageUrl: "https://www.google.com")
        let expect = XCTestExpectation(description: "cell properties set")
        
        sut.cellViewModel = vm
        sut.updateCellProperties(cellViewModel: vm)
        expect.fulfill()
        
        wait(for: [expect], timeout: 3.0)
        
        XCTAssertEqual(sut.cellViewModel?.author, "Mike")
    }
}
