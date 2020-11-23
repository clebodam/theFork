//
//  HomeViewController..swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import UIKit

class HomeViewController: UICollectionViewController, Presentable, HasInteractor,  Coordinable, DiapoaramaCellDelegate  {
    var coordinator: Coordinator?
    var interactor : Interactor?
    var reloadButton: UIButton!
    var shareButton: UIButton!
    var likeButton: UIButton!
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

        //register cells
        self.collectionView.register(DiapoaramaCell.self, forCellWithReuseIdentifier: DiapoaramaCell.reuseIdentifier)
        self.collectionView.register(InfosCell.self, forCellWithReuseIdentifier: InfosCell.reuseIdentifier)
        self.collectionView.register(MapCell.self, forCellWithReuseIdentifier: MapCell.reuseIdentifier)
        self.collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseIdentifier)

        // make collectionbar visible behind navigationbar
        let newInsets = UIEdgeInsets(top: -topbarHeight
                                     , left: 0, bottom: 0, right: 0)
        self.collectionView.contentInset = newInsets;

        homeInteractor()?.getData()
    }

    func homeInteractor() -> HomeInteractor? {
        if let homeInteractor = interactor as? HomeInteractor {
            return homeInteractor
        }
        return nil
    }

    func register(interactor: Interactor) {
        self.interactor =  interactor as? HomeInteractor
    }

    func configureNavigationBarButtonItem() {
        reloadButton = UIButton()
        reloadButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        reloadButton.setImage(UIImage(named: "refresh"), for: .normal)
        reloadButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        reloadButton.layer.cornerRadius = reloadButton.frame.size.width / 2
        reloadButton.imageView?.clipsToBounds = true
        reloadButton.imageView?.contentMode = .scaleAspectFit
        reloadButton .backgroundColor = UIColor.black.withAlphaComponent(0.6)
        reloadButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        shareButton = UIButton()
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        shareButton.layer.cornerRadius = reloadButton.frame.size.width / 2
        shareButton.imageView?.clipsToBounds = true
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton .backgroundColor = UIColor.black.withAlphaComponent(0.6)

        likeButton = UIButton()
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "solid-heart"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        likeButton.layer.cornerRadius = reloadButton.frame.size.width / 2
        likeButton.imageView?.clipsToBounds = true
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton .backgroundColor = UIColor.black.withAlphaComponent(0.6)

        // transparent NavigationBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        let buttonbarItem =  UIBarButtonItem(customView: reloadButton)
        let currWidth = buttonbarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = buttonbarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true

        let sharebarItem =  UIBarButtonItem(customView: shareButton)
        let shareCurrWidth = sharebarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        shareCurrWidth?.isActive = true
        let shareCurrHeight = sharebarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        shareCurrHeight?.isActive = true

        let likebarItem =  UIBarButtonItem(customView: likeButton)
        let likeCurrWidth = sharebarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        likeCurrWidth?.isActive = true
        let likeCurrHeight = sharebarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        likeCurrHeight?.isActive = true

        
        navigationItem.leftBarButtonItem =  buttonbarItem
        navigationItem.rightBarButtonItems =  [likebarItem, sharebarItem]

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
        homeInteractor()?.resetTapped()
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

        guard let type = InfoType(rawValue: indexPath.row), let model = viewModel?.getModelForRow(type) else { return UICollectionViewCell()

        }
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: identifierForType(type), for: indexPath)
        // Configure the cell
        if let cell = cell as? BasicCell {
            cell.feedWithModel(viewModel: model)
        }
        if let cell = cell as? DiapoaramaCell {
            cell.delegate = self
        }
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = view.frame.width // In this example the width is the same as the whole view.
        let height = CGFloat(200)
        return CGSize(width: width, height: height)

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

    func showDiaporama() {
        self.homeInteractor()?.interactorShowDiaporama()
    }

    @objc func share() {
        self.homeInteractor()?.interactorShare()
    }

   @objc  func like() {
        self.homeInteractor()?.interactorLike()
    }


}

