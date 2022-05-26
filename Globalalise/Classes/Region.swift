//
//  Region.swift
//  Globalalise
//
//  Created by Snow.y.wu on 4/21/22.
//

import Foundation

public struct Region: Equatable{
    
    public enum Errors: Swift.Error {
        case onlyENLocale
        case regionCodeEmpty
    }
    
    /// Region Name
    public let name: String
    
    /// Region Code
    public let code: String
    
    /// Region local language
    private(set) var localeList: [Locale] = [Locale]()
    
    public init(_ name: String, _ locale: Locale) {
        self.name = name
        guard let regionCode = locale.regionCode else { fatalError("locale.regionCode is empty, please check you locale") }
        self.code = regionCode
        self.localeList.append(locale)
    }
    
    internal mutating func append(_ locale: Locale) {
        localeList.append(locale)
    }
    
    public func localizedLanguages() throws -> [LocalizedLanguage] {
        return try localeList.map { locale in
            if let languageCode = locale.languageCode,
               let language = locale.localizedString(forLanguageCode: languageCode)?.localizedCapitalized {
                return LocalizedLanguage(language, locale)
            } else {
                throw LocalizedLanguage.Errors.languageCodeEmpty
            }
        }
    }
}

extension Region: CustomStringConvertible {
    public var description: String {
        // create and return a String that is how
        // you’d like a Store to look when printed
        return "name:\(name)->Locales:\(localeList)"
    }
}


extension String {
    
    /// region Code to flag's emoji
    /// - Returns: Region flag emoji
    public func flag() -> String {
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        let flag = self
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(flagBase + $0.value)?.description }
            .joined()
        return flag
    }
}
