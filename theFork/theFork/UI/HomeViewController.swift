//
//  HomeViewController..swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import UIKit

class HomeViewController: UICollectionViewController, Presentable, Coordinable  {

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


extension HomeViewController {
  //1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0
  }

  //2
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  //3
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    cell.backgroundColor = .black
    // Configure the cell
    return cell
  }
}

