//
//  RestaurantViewModel.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import Foundation
import CoreLocation
import UIKit


struct RestaurantViewModel: RestaurantProtocol {

    var infos: RestaurantInfosProtocol?

    var mapInfos: RestaurantMapProtocol?

    var picsDiaporama: RestaurantDiaporamaProtocol?

    init(rawRestaurant: RawRestaurant) {
        infos = RestaurantInfosViewModel(rawRestaurant: rawRestaurant)
        mapInfos = RestaurantMapViewModel(rawRestaurant: rawRestaurant)
        picsDiaporama = RestaurantDiaporamaViewModel(rawRestaurant: rawRestaurant)
    }
}


struct RestaurantInfosViewModel: RestaurantInfosProtocol {
    var name: String?

    var address: String?

    var city: String?

    var zipcode: String?

    var speciality: String?

    var url: String?

    var currencyCode: String?

    var cardPrice: Int?

    var tripadvisorAvgRate: Float?

    var tripadvisorRateCount: Int?

    var avgRate: Float?

    var rateCount: Int?

    init(rawRestaurant: RawRestaurant) {
        name = rawRestaurant.name
        address = rawRestaurant.address
        city = rawRestaurant.city
        zipcode = rawRestaurant.zipcode
        speciality = rawRestaurant.speciality
        url = rawRestaurant.url
        currencyCode = rawRestaurant.currencyCode
        cardPrice = rawRestaurant.cardPrice
        tripadvisorAvgRate = rawRestaurant.tripadvisorAvgRate
        tripadvisorRateCount = rawRestaurant.tripadvisorRateCount
        avgRate = rawRestaurant.avgRate
        rateCount = rawRestaurant.rateCount
    }

    func getFullAddress() -> String{
       return "\(self.address ?? "") \(self.city ?? "") \(self.zipcode ?? "")"
    }

    
    func averrageAttributedString() -> NSAttributedString {
        let note = "\(avgRate ?? 0)"
        let ref = "/10"
        let boldfont = UIFont.boldSystemFont(ofSize: 24.0)
        let normalfont = UIFont.boldSystemFont(ofSize: 16.0)
        let noteAttributes = [NSAttributedString.Key.font: boldfont]
        let noramlAttributes = [NSAttributedString.Key.font: normalfont]
        let attributedNote = NSAttributedString(string: note, attributes: noteAttributes)
        let attributedRef = NSAttributedString(string: ref, attributes: noramlAttributes)

        return attributedNote + attributedRef
    }

    func forkReviewString() -> String {
        return "\(rateCount ?? 0) Fork review(s)"
    }

    func tripAdvisorReviewString() -> String {
        return "\(tripadvisorRateCount ?? 0) TripAdvisor review(s)"
    }

}

struct RestaurantMapViewModel: RestaurantMapProtocol {
    var gpsLat: Double?

    var gpsLong: Double?

    init(rawRestaurant: RawRestaurant) {
        gpsLat = rawRestaurant.gpsLat
        gpsLong = rawRestaurant.gpsLong
    }

    func getLocation() -> CLLocation? {
        guard let gpsLat = gpsLat, let gpsLong = gpsLong else {
            return nil
        }
        return CLLocation(latitude: gpsLat, longitude: gpsLong)
    }
}

struct RestaurantDiaporamaViewModel: RestaurantDiaporamaProtocol {
    var picsDiaporama: [String]?

    init(rawRestaurant: RawRestaurant) {
        picsDiaporama = rawRestaurant.picsDiaporama
    }

    func diaporamaCount() -> Int {
        return  picsDiaporama?.count ?? 0
    }

    func showMore() -> Bool {

        return diaporamaCount() > 1
    }

    func getTitle() -> String {
        return  showMore() ? "See all \(diaporamaCount()) photos >" : ""
    }
}



