//
//  HomeInteractor.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation

class HomeInteractor: Interactor {
    var presenter: Presenter?
    var worker: NetWorkManagerProtocol?
    func register(presenter: Presenter) {
        self.presenter = presenter
    }

    var homePresenter : HomePresenter? {
        get {
            return presenter as? HomePresenter
        }
    }

    func resetTapped() {
        getData()
    }

    func getData() {
        self.homePresenter?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.worker?.getData(completion: { rawRestaurant, error in
                guard let raw =  rawRestaurant  else {
                    return
                }
                let model = RestaurantViewModel(rawRestaurant: raw)
                self.updateModel(model)
                self.homePresenter?.stopLoading()
            })
        }
    }

    func updateModel(_ model: RestaurantProtocol) {
        self.homePresenter?.viewModelData  = model
        self.homePresenter?.reloadData()
    }
}