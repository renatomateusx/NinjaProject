//
//  HomeCoordinator.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private weak var homeViewController: HomeViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(with: NinjaRepository(), coordinator: self)
        
        let vc = HomeViewController()
        vc.viewModel = viewModel
        vc.title = .localized(.creatures)
        navigationController.pushViewController(vc, animated: false)
        homeViewController = vc
    }
    
    func goToCategoriesItems(category: NinjaCategory?, items: Equipments, viewModel: HomeViewModel?) {
        DispatchQueue.main.async {
            let vc = CategoryItemsViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.viewModel = viewModel
            vc.data = items
            vc.title = category?.rawValue.uppercased()
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func goToItemDetail(item: Equipment) {
        DispatchQueue.main.async {
            let vc = DetailItemViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.data = [item]
            vc.title = item.name.uppercased()
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func goToCreatureItems(category: NinjaCategory?, items: Creatures, viewModel: HomeViewModel?) {
        DispatchQueue.main.async {
            let vc = CreaturesListViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.viewModel = viewModel
            vc.data = items
            vc.title = category?.rawValue.uppercased()
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}

