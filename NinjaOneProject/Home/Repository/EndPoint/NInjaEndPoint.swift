//
//  NInjaEndPoint.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation

struct NInjaEndPoint {
    let category: NinjaCategory?
    let id: Int?
    let appConfiguration: AppConfigurations

    var host: String {
        return appConfiguration.apiBaseURL
    }
    
    var appId: String {
        return appConfiguration.apiKey
    }

    var path: String {
        return "api/v2"
    }
    
    var url: URL {
        return URL(string: "\(host)\(path)")!
    }
    
    var categoryPath: URL {
        if let cat = self.category?.rawValue {
            return URL(string: "\(host)\(path)/category/\(cat)")!
        }
        return url
    }
    
    var idPath: URL {
        if let id = self.id {
            return URL(string: "\(host)\(path)/entry/\(id)")!
        }
        return url
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
