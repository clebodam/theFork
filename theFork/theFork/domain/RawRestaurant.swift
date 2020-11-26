//
//  RawRestaurant.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation

protocol RawRestaurantProtocol {
    var id: Int? { get }
    var address: String? { get }
    var name: String? { get }
    var city: String? { get }
    var zipcode: String? { get }
    var speciality: String? { get }
    var url: String? { get }
    var gpsLat: Double? { get }
    var gpsLong: Double? { get }
    var currencyCode: String? { get }
    var cardPrice: Int? { get }
    var tripadvisorAvgRate: Float? { get }
    var tripadvisorRateCount: Int? { get }
    var avgRate: Float? { get }
    var rateCount: Int? { get }
    var picsDiaporama: [String]? { get }
}



struct RawRestaurant: Decodable, RawRestaurantProtocol {
    enum CodingKeys: String, CodingKey {
        case gpsLat = "gps_lat"
        case gpsLong = "gps_long"
        case currencyCode = "currency_code"
        case cardPrice = "card_price"
        case tripadvisorAvgRate = "tripadvisor_avg_rate"
        case tripadvisorRateCount = "tripadvisor_rate_count"
        case avgRate = "avg_rate"
        case rateCount = "rate_count"
        case picsDiaporama = "pics_diaporama"
        case id, address, name, city, zipcode, speciality, url
    }

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


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        speciality = try values.decodeIfPresent(String.self, forKey: .speciality)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        gpsLat = try values.decodeIfPresent(Double.self, forKey: .gpsLat)
        gpsLong = try values.decodeIfPresent(Double.self, forKey: .gpsLong)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        cardPrice = try values.decodeIfPresent(Int.self, forKey: .cardPrice)
        tripadvisorAvgRate = try values.decodeIfPresent(Float.self, forKey: .tripadvisorAvgRate)
        tripadvisorRateCount = try values.decodeIfPresent(Int.self, forKey: .tripadvisorRateCount)
        avgRate = try values.decodeIfPresent(Float.self, forKey: .avgRate)
        rateCount = try values.decodeIfPresent(Int.self, forKey: .rateCount)
        picsDiaporama = try values.decodeIfPresent( [String].self, forKey: .picsDiaporama)
    }

}

