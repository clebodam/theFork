//
//  DiaporamaViewController.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import UIKit

//
//  DiaporamaViewController.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import UIKit

class DiaporamaViewController: UICollectionViewController, Presentable, Coordinable  {

    var coordinator: Coordinator?
    var interactor: Interactor?
    var viewModel: RestaurantDiaporamaViewModel?

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let heigth = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width

        layout.itemSize = CGSize(width: width , height: heigth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(  UITapGestureRecognizer(target: self, action: #selector(back)))
        collectionView?.collectionViewLayout = layout
        collectionView?.isPagingEnabled = true
        //register cells
        self.collectionView.register(ScrollingDiaporamaCell.self, forCellWithReuseIdentifier: ScrollingDiaporamaCell.reuseIdentifier)




    }

    @objc func back() {
        if let diapCoordinator =  coordinator as? DiaporamaCoordinator {
            diapCoordinator.dissmiss()
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.diaporamaCount() ?? 0
    }


    override func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ScrollingDiaporamaCell.reuseIdentifier, for: indexPath)
        // Configure the cell
        if let cell = cell as? ScrollingDiaporamaCell {
            let string = viewModel?.picsDiaporama?[indexPath.row]
            cell.feedImageString(string)
        }
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    func updateViews(viewModel: Any?) {
        self.viewModel = viewModel as? RestaurantDiaporamaViewModel
    }

    func register(interactor: Interactor) {
        self.interactor =  interactor as? DiaporamaInteractor
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

