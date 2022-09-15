//
//  NinjaRepositoryMockFailure.swift
//  NinjaOneProjectTests
//
//  Created by Renato Mateus on 14/09/22.
//

import Foundation

@testable import NinjaOneProject

class NinjaRepositoryMockFailure: NinjaRepositoryProtocol {
    var appConfiguration: AppConfigurations = AppConfigurations()
    
    func fetchData(_ page: Int, completion: @escaping (Result<DataClass, Error>) -> Void) {
        completion(.failure(NSError(domain: .localized(.noDataDownloaded),
                                    code: 400,
                                    userInfo: nil)))
    }
    
    
    func fetchDataByCategory(category: NinjaCategory, completion: @escaping (Result<Cat, Error>) -> Void) {
        completion(.failure(NSError(domain: .localized(.noDataDownloaded),
                                    code: 400,
                                    userInfo: nil)))
    }
    
    func fetchById(id: Int, completion: @escaping (Result<Item, Error>) -> Void) {
        completion(.failure(NSError(domain: .localized(.noDataDownloaded),
                                    code: 400,
                                    userInfo: nil)))
    }
    
    func fetchDataByCreature(creature: NinjaCategory, completion: @escaping (Result<Creature, Error>) -> Void) {
        completion(.failure(NSError(domain: .localized(.noDataDownloaded),
                                    code: 400,
                                    userInfo: nil)))
    }
}
