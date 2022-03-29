////
////  NewsAPIServiceTTest.swift
////  TechTestApplicationTests
////
////  Created by Devayani Purandare on 26/03/22.
////
//
//import XCTest
//@testable import TechTestApplication
//
//class NewsAPIServiceTest: XCTestCase {
//    
//    
//    var sut: NewsDataService?
//    
//    override func setUpWithError() throws {
//        super.setUp()
//        sut = NewsDataService()
//    }
//    
//    override func tearDownWithError() throws {
//        sut = nil
//        super.tearDown()
//    }
//    
////    func testapiGETMethod() {
////
////        // Given A apiservice
////        let sut = self.sut!
////
////        // When fetch popular photo
////        let expect = XCTestExpectation(description: "callback")
////        sut.getNewsFromServer { (success, news, error) in
////            let newsArray = StubGenerator.stubNews()
////            expect.fulfill()
////            XCTAssertEqual( newsArray.count, 2)
////            for newsobj in newsArray {
////                XCTAssertNotNil(newsobj.author)
////            }
////        }
////        wait(for: [expect], timeout: 5)
////    }
////
////    func testapiGETMethodForFailure() {
////
////        // Given A apiservice
////        let sut = self.sut!
////
////        // When fetch popular photo
////        let expect = XCTestExpectation(description: "callback")
////        sut.getNewsFromServer { (success, news, error) in
////            //THEN
////            let newsArray: NewsArray? = nil
////            let error = APIError.responseError
////            expect.fulfill()
////
////            XCTAssertEqual(newsArray, nil)
////            XCTAssertNotNil(error)
////        }
////        wait(for: [expect], timeout: 3)
////    }
//    
//    func testGetNewsFromServerForSuccessData() async {
//        
//        // Given A apiservice
//        let sut = self.sut!
//        var newsArray = NewsArray()
//        
//        // When fetch popular photo
//        let expect = XCTestExpectation(description: "return data after success")
//        do{
//            _ = try await sut.getNewsData(api: .list)
//            newsArray = try StubGenerator.stubNews()
//            expect.fulfill()
//        }
//        catch{
//            
//        }
//        XCTAssertEqual( newsArray.count, 2)
//        for newsobj in newsArray {
//            XCTAssertNotNil(newsobj.author)
//        }
//        
//        await waitForExpectations(timeout: 3)
//
//    }
//    
//    func testGetNewsFromServerWhenResponseIsFailed() async {
//        
//        // Given A apiservice
//        let sut = self.sut!
//        
//        // When fetch popular photo
//        let expect = XCTestExpectation(description: "return error after failure")
//        do{
//        _ = try await sut.getNewsData(api: .invalid)
//            let error = APIError.responseError
//            expect.fulfill()
//            
//            XCTAssertNotNil(error)
//        }
//        catch{
//            
//        }
//    }
//    
//    
//}
