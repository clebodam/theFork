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
    var viewModel: RestaurantViewModel?


    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.collectionViewLayout = layout
        configureNavigationBarButtonItem()
        self.collectionView.register(DiapoaramaCell.self, forCellWithReuseIdentifier: DiapoaramaCell.reuseIdentifier)
        self.collectionView.register(InfosCell.self, forCellWithReuseIdentifier: InfosCell.reuseIdentifier)
        self.collectionView.register(MapCell.self, forCellWithReuseIdentifier: MapCell.reuseIdentifier)
        self.collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseIdentifier)
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

    func updateViews(viewModel: Any?) {
        self.viewModel = viewModel as? RestaurantViewModel
        self.collectionView?.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.rowNumber() ?? 0
    }


    override func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let type = InfoType(rawValue: indexPath.row), let model = modelForType(type) else { return UICollectionViewCell()

        }
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: identifierForType(type), for: indexPath)
        // Configure the cell
        if let cell = cell as? BasicCell {
            cell.feedWithModel(viewModel: model)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = InfoType(rawValue: indexPath.row), let model = modelForType(type) as? RestaurantDiaporamaViewModel, type == .diaporama else { return
        }

        if let homeCoordiantor = coordinator as? HomeCoordinator {
            print("go to diaporama, \(model)")
            homeCoordiantor.goToDiaporama(model)
        }


    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = view.frame.width // In this example the width is the same as the whole view.
        let height = CGFloat(200)
        return CGSize(width: width, height: height)

    }

    func modelForType(_ type: InfoType) -> ModelProtocol? {
        switch type {
        case InfoType.diaporama:
            return self.viewModel?.getModelForRow(InfoType.diaporama)
        case InfoType.infos:
            return self.viewModel?.getModelForRow(InfoType.infos)
        case InfoType.map:
            return self.viewModel?.getModelForRow(InfoType.map)
        case InfoType.button:
            return self.viewModel?.getModelForRow(InfoType.button)
        }
    }

    func identifierForType(_ type: InfoType) -> String {
        switch type {
        case InfoType.diaporama:
            return DiapoaramaCell.reuseIdentifier
        case InfoType.infos:
            return InfosCell.reuseIdentifier
        case InfoType.map:
            return MapCell.reuseIdentifier
        case InfoType.button:
            return ButtonCell.reuseIdentifier
        }
    }
}

