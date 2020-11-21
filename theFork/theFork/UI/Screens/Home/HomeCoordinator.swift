//
//  HomeCoordinator.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator   {
    var context: Coordinable?
    var navigationController: CoordinableNavivationController?

    required init() {
    }

    func start() {
        context?.registerCoordinator(coordinator: self)
        self.push(self.context)
    }

    func goToDiaporama( _ viewModel:ModelProtocol?) {
        let screen =  DiaporamaViewController()
        let diaporamaCoordinator = DiaporamaCoordinator(from: context, screen: screen)
        if let context = context as? DiaporamaViewController {
            let presenter = DiaporamaPresenter()
            presenter.viewModelData = viewModel as? RestaurantDiaporamaViewModel
            presenter.register(presentable: context)
            let interactor = DiaporamaInteractor()
            interactor.register(presenter: presenter)
            screen.register(interactor: interactor)
            screen.registerCoordinator(coordinator: diaporamaCoordinator)
        }
        diaporamaCoordinator.start()
    }
}
