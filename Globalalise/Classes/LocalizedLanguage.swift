//
//  LocalizedLanguage.swift
//  Globalalise
//
//  Created by Snow.y.wu on 4/21/22.
//

import Foundation


public struct LocalizedLanguage : Equatable {
    
    public enum Errors: Swift.Error {
        case languageCodeEmpty
    }
    
    public let name: String
    public let locale: Locale
    
    public init(_ name: String, _ locale: Locale) {
        self.name = name
        self.locale = locale
    }
}

extension LocalizedLanguage : CustomStringConvertible {
    
    public var description: String {
        return "name:\(name) -> languageCode:\(String(describing: locale.languageCode))"
    }
}
