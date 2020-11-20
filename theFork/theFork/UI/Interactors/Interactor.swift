//
//  Interactor.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation

protocol Interactor: class {
    var presenter: Presenter? { get set }
    func register(presenter: Presenter)
}
