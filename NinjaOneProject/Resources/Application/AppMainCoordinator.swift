//
//  AppMainCoordinator.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import UIKit

class AppMainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
