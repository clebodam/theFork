//
//  HomeCoordinator.swift
//  theFork
//
//  Created by Damien on 19/11/2020.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator   {
    var context: Coordinable?
    var navigationController: CoordinableNavivationController?

    required init() {
    }

    func start() {
        context?.registerCoordinator(coordinator: self)
        self.push(self.context)
    }
}
