//
//  HomeViewController..swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import UIKit

class HomeViewController: UIViewController, Presentable, Coordinable {

    var coordinator: Coordinator?
    var interactor : HomeInteractor?
    var reloadButton: UIButton!


    func updateViews() {

    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarButtonItem()
        interactor?.getData()
    }

    func register(interactor: Interactor) {
        self.interactor =  interactor as? HomeInteractor
    }

    func configureNavigationBarButtonItem() {
        reloadButton = UIButton()
        reloadButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        reloadButton.setImage(UIImage(named: "refresh"), for: UIControl.State())
        navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: reloadButton)
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.reloadButton.infiniteRotate()
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.reloadButton.removeAllAnimations()
        }
    }

    @objc func resetTapped() {
        interactor?.resetTapped()
    }


}

