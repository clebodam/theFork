//
//  HomeCoordinator.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

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

    func launchRouting(coord: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: nil, message: "open in Map ?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coord, addressDictionary:nil))
            mapItem.name = "Target location"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.fixNegativeWidthConstraints()
        self.context?.present(alertController, animated: true, completion: nil)
    }
}

extension UIAlertController {
    func fixNegativeWidthConstraints() {

        for subview in self.view.subviews {
            for constraint in subview.constraints {
                if constraint.constant < 0 {
                    constraint.constant = -constraint.constant
                }
            }
        }
    }
}
