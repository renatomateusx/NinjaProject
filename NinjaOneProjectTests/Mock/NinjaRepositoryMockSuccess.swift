//
//  NinjaRepositoryMockSuccess.swift
//  NinjaOneProjectTests
//
//  Created by Renato Mateus on 14/09/22.
//

import Foundation

@testable import NinjaOneProject

class NinjaRepositoryMockSuccess: NinjaRepositoryProtocol {

    var appConfiguration: AppConfigurations = AppConfigurations()
    
    func fetchData(_ page: Int, completion: @escaping (Result<DataClass, Error>) -> Void) {
        let fakeDataModel: DataClass = DataClass(creatures: nil, equipment: [],
                                                 materials: [], monsters: [],
                                                 treasure: [])
        completion(.success(fakeDataModel))
    }
    
    func fetchDataByCategory(category: NinjaCategory, completion: @escaping (Result<Cat, Error>) -> Void) {
        let fakeData: Cat = Cat(data: [])
        
        completion(.success(fakeData))
    }
    
    func fetchById(id: Int, completion: @escaping (Result<Item, Error>) -> Void) {
        let fakeData: Item = Item(data: Equipment(category: .equipment, commonLocations: nil, cookingEffect: nil, equipmentDescription: "", heartsRecovered: nil, id: 0, image: "", name: "", drops: nil, attack: nil, defense: nil))
        
        
        completion(.success(fakeData))
    }
    
    func fetchDataByCreature(creature: NinjaCategory, completion: @escaping (Result<Creature, Error>) -> Void) {
        let fakeData: Creature = Creature(data: Creatures(food: [], nonFood: []))
        
        
        completion(.success(fakeData))
    }
}
