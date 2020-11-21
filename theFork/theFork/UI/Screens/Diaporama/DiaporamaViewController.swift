//
//  DiaporamaViewController.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import UIKit

class DiaporamaViewController: UIViewController, Presentable, Coordinable  {

    var coordinator: Coordinator?
    var interactor: Interactor?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(  UITapGestureRecognizer(target: self, action: #selector(back)))
        // Do any additional setup after loading the view.
    }

    @objc func back() {
        if let diapCoordinator =  coordinator as? DiaporamaCoordinator {
            diapCoordinator.dissmiss()
        }
    }
    override func loadView() {
        view = UIView()
        view.backgroundColor = .red
    }

    func updateViews(viewModel: Any?) {

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
