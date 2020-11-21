//
//  DiaporamaCoordinator.swift
//  theFork
//
//  Created by Damien on 21/11/2020.
//

import Foundation
import UIKit

class DiaporamaCoordinator: Coordinator {
    var context: Coordinable?

    var navigationController: CoordinableNavivationController?

    required init() {
    }

    func start() {
        context?.registerCoordinator(coordinator: self)
        self.present(self.context)
    }

    
}
