//
//  ViperDemoTests.swift
//  ViperDemoTests
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import ViperDemo

class ViperDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInteractor() {
        // This is an example of a functional test case.
        let expectation = expectationWithDescription("Get chat history test")
        
        class TestInteractorHandler: InteractorDelegate {
            var expect: XCTestExpectation?
            func responseOnSuccess(response:Mappable) {
                if let _ = response as? ChatThreadModel {
                    expect?.fulfill()
                } else {
                    XCTFail("Get chat history failed")
                }
            }
            func responseOnFailure(error: ErrorType?) {
                XCTFail("Get chat history failed")
            }
        }
        let testHandler = TestInteractorHandler()
        testHandler.expect = expectation
        let testInteractor = Interactor(handler: testHandler)
        testInteractor.getChatThread()
        
        self.waitForExpectationsWithTimeout(20) { error in
            XCTAssertNil(error, "Something went horribly wrong")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
