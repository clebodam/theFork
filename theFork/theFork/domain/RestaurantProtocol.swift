//
//  RestaurantProtocol.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import Foundation



protocol ModelProtocol {

}

protocol RestaurantProtocol {

    var infos: RestaurantInfosProtocol? { get set }
    var mapInfos: RestaurantMapProtocol? { get set }
    var picsDiaporama: RestaurantDiaporamaProtocol? { get set }
}


protocol RestaurantInfosProtocol: ModelProtocol {
    var name: String? { get set }
    var city: String? { get set }
    var zipcode: String? { get set }
    var speciality: String? { get set }
    var url: String? { get set }
    var currencyCode: String? { get set }
    var cardPrice: Int? { get set }
    var tripadvisorAvgRate: Float? { get set }
    var tripadvisorRateCount: Int? { get set }
    var avgRate: Float? { get set }
    var rateCount: Int? { get set }
}

protocol RestaurantMapProtocol: ModelProtocol {
    var gpsLat: Double? { get set }
    var gpsLong: Double? { get set }
}
protocol RestaurantDiaporamaProtocol: ModelProtocol{
    var picsDiaporama: [String]? { get set }
}

protocol ButtonProtocol: ModelProtocol{
    func getTitle() -> String
}
