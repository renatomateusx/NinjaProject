//
//  NinjaRepository.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation

protocol NinjaRepositoryProtocol: AnyObject {
    
    var appConfiguration: AppConfigurations { get }
    
    func fetchData(_ page: Int, completion: @escaping(Result<DataClass, Error>) -> Void)
    func fetchDataByCategory(category: NinjaCategory, completion: @escaping(Result<Cat, Error>) -> Void)
    func fetchById(id: Int, completion: @escaping(Result<Item, Error>) -> Void)
    func fetchDataByCreature(creature: NinjaCategory, completion: @escaping(Result<Creature, Error>) -> Void)
}

class NinjaRepository {
    private let service: NetworkRepository
    let appConfiguration: AppConfigurations
    
    init(service: NetworkRepository = NetworkRepository(),
         appConfiguration: AppConfigurations = AppConfigurations()) {
        self.service = service
        self.appConfiguration = appConfiguration
    }
}

extension NinjaRepository: NinjaRepositoryProtocol {
    func fetchData(_ page: Int, completion: @escaping(Result<DataClass, Error>) -> Void) {
        let endpoint = NInjaEndPoint(category: nil, id: nil, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.url, completion: completion)
    }
    
    func fetchDataByCategory(category: NinjaCategory, completion: @escaping(Result<Cat, Error>) -> Void) {
        let endpoint = NInjaEndPoint(category: category, id: nil, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.categoryPath, completion: completion)
    }
    
    func fetchById(id: Int, completion: @escaping(Result<Item, Error>) -> Void) {
        let endpoint = NInjaEndPoint(category: nil, id: id, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.idPath, completion: completion)
    }
    
    func fetchDataByCreature(creature: NinjaCategory, completion: @escaping(Result<Creature, Error>) -> Void) {
        let endpoint = NInjaEndPoint(category: creature, id: nil, appConfiguration: self.appConfiguration)
        _ = service.request(for: endpoint.categoryPath, completion: completion)
    }
}
