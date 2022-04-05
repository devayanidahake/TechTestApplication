//
//  UIDevice+JailbrokenTest.swift
//  TechTestApplicationTests
//
//  Created by Devayani Purandare on 04/04/22.
//

import Foundation
import XCTest

@testable import TechTestApplication

class UIDeviceJailbrokenTest: XCTestCase {
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testIFDeviceIsJailBroken() {
        // Given
        var isDeviceJailBreak = false
        let expect = XCTestExpectation(description: "Device is jailbroken")
        // When
         isDeviceJailBreak = UIDevice.current.checkisDeviceJailBrocken()
        expect.fulfill()
        // Then
        wait(for: [expect], timeout: 5.0)
        XCTAssertFalse(isDeviceJailBreak)
    }
}
