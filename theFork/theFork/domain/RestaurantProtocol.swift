//
//  RestaurantProtocol.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import Foundation

enum InfoType: Int{
    case diaporama
    case infos
    case map

}

protocol ModelProtocol {

}

protocol RestaurantProtocol {

    var infos: RestaurantInfosProtocol? { get }
    var mapInfos: RestaurantMapProtocol? { get }
    var picsDiaporama: RestaurantDiaporamaProtocol? { get }
}

extension RestaurantProtocol {
    func getModelForRow(_ row: InfoType) -> ModelProtocol? {
        switch row {
        case .diaporama:
            return picsDiaporama
        case .infos:
            return infos
        case .map:
            return mapInfos
        }
    }

    func rowNumber() -> Int {
        return 3
    }
}


protocol RestaurantInfosProtocol: ModelProtocol {
    var name: String? { get }
    var address: String? { get }
    var city: String? { get }
    var zipcode: String? { get }
    var speciality: String? { get }
    var url: String? { get }
    var currencyCode: String? { get }
    var cardPrice: Int? { get }
    var tripadvisorAvgRate: Float? { get }
    var tripadvisorRateCount: Int? { get }
    var avgRate: Float? { get }
    var rateCount: Int? { get }
}

protocol RestaurantMapProtocol: ModelProtocol {
    var gpsLat: Double? { get }
    var gpsLong: Double? { get }
}
protocol RestaurantDiaporamaProtocol: ModelProtocol{
    var picsDiaporama: [String]? { get }
}

