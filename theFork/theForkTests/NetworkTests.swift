//
//  NetworkTests.swift
//  TestLeBonCoinTests
//
//  Created by Damien on 25/09/2020.
//

import Foundation
import XCTest


@testable import theFork
class NetworkTests: XCTestCase {
    private let RESTAURANT_URL = "https://raw.githubusercontent.com/clebodam/theFork/master/theFork/jsonTest"
    private let RESTAURANT_URL_BAD_PARSING = "https://raw.githubusercontent.com/clebodam/theFork/master/theFork/json_bad_parsing"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFailBadRoute() throws {
        let nwManager = NetWorkManager()
        let testFailExpectation = expectation(description: "testFailExpectation")
        let url = ""
        nwManager.get(RawRestaurant.self ,route: url) { result in
            switch result {
            case .success:
               XCTAssertTrue(false)
            case .failure(let error) :
                if let error = error as? NetworkError {
                    switch error {
                    case .badUrl:
                        XCTAssertTrue(true)
                    default:
                        XCTAssertTrue(false)
                    }

                } else {
                    XCTAssertTrue(false)
                }
            }
            testFailExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testFailBadSerialization() throws {
        let nwManager = NetWorkManager()
        let testFailExpectation = expectation(description: "testFailExpectation")

        nwManager.get(RawRestaurant.self, route: RESTAURANT_URL_BAD_PARSING) { result in
            switch result {
            case .success:
               XCTAssertTrue(false)
            case .failure(let error):
                if let error = error as? NetworkError {
                    switch error {
                    case .serialization:
                        XCTAssertTrue(true)
                    default:
                        XCTAssertTrue(false)
                    }

                } else {
                    XCTAssertTrue(false)
                }
            }
            testFailExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testGoodUrLandGoodSerialization() throws {
        let nwManager = NetWorkManager()
        let testExpectation = expectation(description: "testExpectation")

        nwManager.get(RawRestaurant.self, route: RESTAURANT_URL) { result in
            switch result {
            case .success:
               XCTAssertTrue(true)
            case .failure:
            XCTAssertTrue(false)
            }
            testExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
