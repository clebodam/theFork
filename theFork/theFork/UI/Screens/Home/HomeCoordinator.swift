//
//  HomeCoordinator.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator   {
    weak var context: Coordinable?
    var navigationController: CoordinableNavivationController?

    required init() {
    }

    func start() {
        context?.registerCoordinator(coordinator: self)
        self.push(self.context)
    }

    func goToDiaporama( _ viewModel:ModelProtocol?) {
        let screen =  DiaporamaViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let diaporamaCoordinator = DiaporamaCoordinator(from: context, screen: screen)

            let presenter = DiaporamaPresenter()
            presenter.viewModelData = viewModel as? RestaurantDiaporamaViewModel
            presenter.register(presentable: screen)
            let interactor = DiaporamaInteractor()
            interactor.register(presenter: presenter)
            screen.register(interactor: interactor)
            screen.updateViews(viewModel: viewModel)
            screen.registerCoordinator(coordinator: diaporamaCoordinator)

        diaporamaCoordinator.start()
    }

    func presentAlert(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)


        let action = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }
        alertController.addAction(action)
        self.context?.present(alertController, animated: true, completion: nil)
    }

}
