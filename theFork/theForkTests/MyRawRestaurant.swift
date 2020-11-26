//
//  MyRawRestaurant.swift
//  theForkTests
//
//  Created by Damien on 26/11/2020.
//

import Foundation
@testable import theFork
class MyRawRestaurant : RawRestaurantProtocol {
    var id: Int?

    var address: String?

    var name: String?

    var city: String?

    var zipcode: String?

    var speciality: String?

    var url: String?

    var gpsLat: Double?

    var gpsLong: Double?

    var currencyCode: String?

    var cardPrice: Int?

    var tripadvisorAvgRate: Float?

    var tripadvisorRateCount: Int?

    var avgRate: Float?

    var rateCount: Int?

    var picsDiaporama: [String]?

    // init for tests
    init() {
        id = 0
        address = "address"
        name = "name"
        city = "city"
        zipcode = "zipCode"
        speciality = "speciality"
        url = "url"
        gpsLat = 1.0
        gpsLong = 1.0
        currencyCode = "currencyCode"
        cardPrice = 10
        tripadvisorAvgRate = 1.0
        tripadvisorRateCount = 1
        avgRate = 1.0
        rateCount = 1
        picsDiaporama = ["1","2","3"]
    }
}
