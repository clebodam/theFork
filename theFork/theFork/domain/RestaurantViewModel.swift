//
//  RestaurantViewModel.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import Foundation
import CoreLocation

enum InfoType {
    case diaporama
    case infos
    case map
    case button

}

struct RestaurantViewModel: RestaurantProtocol {

    var infos: RestaurantInfosProtocol?

    var mapInfos: RestaurantMapProtocol?

    var picsDiaporama: RestaurantDiaporamaProtocol?

    var buttonModel: ButtonProtocol?

    init(rawRestaurant: RawRestaurant) {
        infos = RestaurantInfosViewModel(rawRestaurant: rawRestaurant)
        mapInfos = RestaurantMapViewModel(rawRestaurant: rawRestaurant)
        picsDiaporama = RestaurantDiaporamaViewModel(rawRestaurant: rawRestaurant)
        buttonModel = ButtonViewModel()
    }

    func getModelForRow(_ row: InfoType) -> ModelProtocol? {
        switch row {
        case .diaporama:
            return picsDiaporama
        case .infos:
            return infos
        case .map:
            return mapInfos
        case .button:
            return buttonModel
        }
    }
}


struct RestaurantInfosViewModel: RestaurantInfosProtocol {
    var name: String?

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
}

struct ButtonViewModel: ButtonProtocol {
    func getTitle() -> String {
        return "titre du bouton"
    }
}


