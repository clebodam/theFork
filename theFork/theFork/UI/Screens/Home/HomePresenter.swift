//
//  HomePresenter.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import UIKit

class HomePresenter : Presenter {
    weak var presentable: Presentable?

    func register(presentable: Presentable) {
        self.presentable = presentable
    }

    var homeScreen: HomeViewController? {
        get  {
            return self.presentable as? HomeViewController
        }
    }

    var viewModelData: RestaurantProtocol?

    func reloadData() {
        DispatchQueue.main.async { [self] in
            self.homeScreen?.updateViews(viewModel: viewModelData)
        }
    }

    func modelForType(_ type: InfoType) -> ModelProtocol? {
       return  viewModelData?.getModelForRow(type)
    }

    func startLoading() {
        self.homeScreen?.startLoading()
    }

    func stopLoading() {
        self.homeScreen?.stopLoading()
    }

    func presenterShowDiaporama() {
        if let homeCoordinator = self.homeScreen?.coordinator as? HomeCoordinator {
            let model = modelForType(.diaporama)
            print("go to diaporama, \(String(describing: model))")
            homeCoordinator.goToDiaporama(model)
        }
    }

    func presentAlert(_ title: String, _ message: String) {
        if let homeCoordinator = self.homeScreen?.coordinator as? HomeCoordinator {
            homeCoordinator.presentAlert(title: title, message: message)
        }
    }

    func presenterShare() {
        presentAlert("Share", "you just shared this place.")

    }

    func presenterLike() {
        presentAlert("Like", "you just liked this place.")
    }

}


