//
//  Globalalise.swift
//  Globalalise
//
//  Created by Snow.y.wu on 4/19/22.
//

import Foundation


public struct Globalalise : GlobalaliseProtocol {
    
    
    /// Only en env formate, it's default
    public let enLocale: Locale
    
    /// Array of NSLocale objects. Always has at least one locale.
    public let availableLocales: [Locale]
    
    public struct SwitchedToLocaleNotification {
        public static let Name = Notification.Name("Globalalise.SwitchedToLocaleNotification")
        
        /// value is locale
        public static let Key = "Globalalise.SwitchedToLocaleNotification.key"
    }
    
    public init(availableLocales: [Locale]) {
        self.enLocale = Locale(identifier: "en")
        self.availableLocales = availableLocales
    }
}


extension Globalalise : SettingLARProtocol {
    
    public func localizationLocale() -> Locale? {
        SettingLAGManager.shared.localizationLocale()
    }
    
    public func loadAllRegions() throws -> [Region] {
        try SettingLAGManager.shared.loadAllRegions(by: self)
    }
    
    public func clickOnRegion(_ region: Region) throws -> [LocalizedLanguage] {
        try SettingLAGManager.shared.clickOnRegion(region)
    }
    
    public func clickOnLocalizedLanguage(_ localizedLanguage: LocalizedLanguage) -> Locale {
        SettingLAGManager.shared.clickOnLocalizedLanguage(localizedLanguage)
    }
    
    public func switched(to locale: Locale) {
        SettingLAGManager.shared.switched(to: locale)
    }
}

