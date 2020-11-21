//
//  DiaporamaPresenter.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import Foundation

class DiaporamaPresenter: Presenter {
    var presentable: Presentable?
    
    func register(presentable: Presentable) {
        self.presentable = presentable
    }

    var DiaporamaScreen: DiaporamaViewController? {
        get  {
            return self.presentable as? DiaporamaViewController
        }
    }

    var viewModelData: RestaurantDiaporamaProtocol?

    
    
}
