//
//  HomeInteractor.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import CoreLocation

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

    func interactorShowDiaporama() {

        homePresenter?.presenterShowDiaporama()
    }

    func interactorShare() {
        homePresenter?.startLoading()
        self.worker?.doSomeLikeOrShareMockAction {
            self.homePresenter?.presenterShare()
            self.homePresenter?.stopLoading()
        }

    }

    func interactorLike() {
        homePresenter?.startLoading()
        self.worker?.doSomeLikeOrShareMockAction {
            self.homePresenter?.presenterLike()
            self.homePresenter?.stopLoading()
        }
    }

    func interactorBook() {
        homePresenter?.startLoading()
        self.worker?.doSomeLikeOrShareMockAction {
            self.homePresenter?.presenterBook()
            self.homePresenter?.stopLoading()
        }
    }

    func interactorDidSelectCoordinates(_ location: CLLocationCoordinate2D) {
        homePresenter?.presenterDidSelectCoordinates(location)
    }

}
