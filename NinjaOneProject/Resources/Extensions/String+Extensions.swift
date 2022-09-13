//
//  String+Extensions.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation
extension String {

    static func localized(_ key: Localizable) -> String {
         return NSLocalizedString(key.rawValue, comment: "")
    }

    static func localizedFormat(_ key: Localizable, _ arguments: CVarArg...) -> String {
        return String(format: .localized(key), arguments: arguments)
    }
}
