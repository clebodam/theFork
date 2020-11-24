//
//  DomainTests.swift
//  theForkTests
//
//  Created by Damien on 24/11/2020.
//

import XCTest
@testable import theFork
class DomainTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testModelGeneration() throws {
        let raw = RawRestaurant()
        let model = RestaurantViewModel(rawRestaurant: raw)
        XCTAssertNotNil(model.infos)
        XCTAssertNotNil(model.picsDiaporama)
        XCTAssertNotNil(model.mapInfos)
        XCTAssertEqual(model.infos?.name, raw.name)
        XCTAssertEqual(model.infos?.address, raw.address)
        XCTAssertEqual(model.infos?.city, raw.city)
        XCTAssertEqual(model.infos?.zipcode, raw.zipcode)
        XCTAssertEqual(model.infos?.currencyCode, raw.currencyCode)
        XCTAssertEqual(model.infos?.avgRate, raw.avgRate)
        XCTAssertEqual(model.infos?.tripadvisorAvgRate, raw.tripadvisorAvgRate)
        XCTAssertEqual(model.infos?.rateCount, raw.rateCount)
        XCTAssertEqual(model.infos?.tripadvisorRateCount, raw.tripadvisorRateCount)
        XCTAssertEqual(model.infos?.url, raw.url)
        XCTAssertEqual(model.infos?.speciality, raw.speciality)
        XCTAssertEqual(model.mapInfos?.gpsLat, raw.gpsLat)
        XCTAssertEqual(model.mapInfos?.gpsLong, raw.gpsLong)
        XCTAssertEqual(model.picsDiaporama?.picsDiaporama, raw.picsDiaporama)


    }

}
