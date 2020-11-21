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

    func startLoading() {
        self.homeScreen?.startLoading()
    }

    func stopLoading() {
        self.homeScreen?.stopLoading()
    }

}


