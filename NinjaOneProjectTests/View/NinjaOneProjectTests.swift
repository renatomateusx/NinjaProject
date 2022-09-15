//
//  NinjaOneProjectTests.swift
//  NinjaOneProjectTests
//
//  Created by Renato Mateus on 12/09/22.
//

import XCTest
import UIKit
import SnapshotTesting
@testable import NinjaOneProject


class NinjaOneProjectTests: XCTestCase {
    
    var window: UIWindow!
    private var mainCoordinator: AppMainCoordinator?
    
    override func setUp() {
        super.setUp()
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }
        
        window = firstWindow
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        mainCoordinator = AppMainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        sleep(3)
        takeSnapshot()
    }
    
    func testFirstItem() {
        if let controller = mainCoordinator?.navigationController.viewControllers.first as? HomeViewController {
            let viewModel = controller.viewModel
            let vc = CategoryItemsViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.viewModel = viewModel
            vc.data = mockItems()
            vc.title = mockItems().first?.name
            mainCoordinator?.navigationController.pushViewController(vc, animated: true)
            sleep(10)
            assertSnapshot(matching:vc, as: .image(precision: 0.99))
        }
    }
    
    func testSecondItem() {
        if let controller = mainCoordinator?.navigationController.viewControllers.first as? HomeViewController {
            let vc = DetailItemViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.data = mockItems()
            vc.title = mockItems().first?.name
            mainCoordinator?.navigationController.pushViewController(vc, animated: true)
            sleep(10)
            assertSnapshot(matching:vc, as: .image(precision: 0.99))
        }
    }
    
    func takeSnapshot() {
        if let vc =  mainCoordinator?.navigationController.viewControllers.first {
            assertSnapshot(matching:vc, as: .image(precision: 0.99))
        }
    }
}


extension NinjaOneProjectTests {
    func getController(controller: AnyObject) -> UIViewController? {
        if let controllers = mainCoordinator?.navigationController.viewControllers {
            for controller in controllers {
                if controller.isKind(of: UIViewController.self) {
                    return controller
                }
            }
        }
        return nil
    }
}


extension NinjaOneProjectTests {
    func mockItems() -> Equipments {
        let equipments: [Equipment] = [
            Equipment(category: .creatures, commonLocations: nil, cookingEffect: nil,
                      equipmentDescription: "his rare butterfly only shows itself when it rains. The organs in its body produce an insulating compound. When made into an elixir, it offers electrical resistance.",
                      heartsRecovered: nil, id: 0,
                      image: "",
                      name: "thunderwing butterfly", drops: nil, attack: nil, defense: nil),
            
            Equipment(category: .creatures, commonLocations: nil, cookingEffect: nil,
                      equipmentDescription: "his freshwater fish lives alongside its less mighty carp ilk. A compound in its liver promotes muscle growth. Dishes cooked with it will temporarily increase your attack power.",
                      heartsRecovered: nil, id: 0,
                      image: "",
                      name: "mighty carp", drops: nil, attack: nil, defense: nil)
        ]
        
        return equipments
    }
}
