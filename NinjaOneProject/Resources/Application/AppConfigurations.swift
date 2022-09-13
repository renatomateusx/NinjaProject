//
//  AppConfigurations.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation

class AppConfigurations {
    lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String
    lazy var apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as! String
    lazy var imagesBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as! String
}
