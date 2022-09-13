//
//  HomeViewModel.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(_ page: Int)
    func fetchDataByCategory(category: Category)
    func fetchById(id: Int)
    
    var monsters: Bindable<DataClass> { get set }
    var equipments: Bindable<Cat> { get set }
    var equipment: Bindable<Item> { get set }
    var error: Bindable<Error> { get set }
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let ninjaService: NinjaRepositoryProtocol
    let coordinator: HomeCoordinator
    var monsters = Bindable<DataClass>()
    var equipments = Bindable<Cat>()
    var equipment = Bindable<Item>()
    var error = Bindable<Error>()
    // MARK: - Inits
    
    init(with service: NinjaRepositoryProtocol, coordinator: HomeCoordinator) {
        self.ninjaService = service
        self.coordinator = coordinator
    }
    
    func fetchData(_ page: Int) {
        ninjaService.fetchData(page) { result in
            switch result {
            
            case .success(let monsters):
                self.monsters.value = monsters
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchDataByCategory(category: Category) {
        ninjaService.fetchDataByCategory(category: category) { result in
            switch result {
            case .success(let equipments):
                self.equipments.value = equipments
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchById(id: Int) {
        ninjaService.fetchById(id: id) { result in
            switch result {
            case .success(let equipment):
                self.equipment.value = equipment
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
