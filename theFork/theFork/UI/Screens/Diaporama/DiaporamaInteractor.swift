//
//  DiaporamaInteractor.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import Foundation

class DiaporamaInteractor: Interactor {
    var presenter: Presenter?

    func register(presenter: Presenter) {
        self.presenter = presenter
    }
}
