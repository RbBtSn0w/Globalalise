//
//  LanguagesAndRegions.swift
//  Globalalise
//
//  Created by Snow.y.wu on 4/21/22.
//

import Foundation


/// Setting Languages And Regions(LAG)
internal class SettingLAGManager {
    
    /// Currently selected localization locale.
    private var _localizationLocale: Locale?
    
    lazy var storage: Storage = {
        return Storage()
    }()
    
    
    static let shared = SettingLAGManager()
    
}


extension SettingLAGManager {
    
    
    /// maybe mutating change Self when invoke this method
    /// - Returns: Locale nullable
    func localizationLocale() -> Locale? {
        if _localizationLocale != nil {
            return _localizationLocale
        }
        if let localeIdentifier = storage.string(forKey: .selectedLocaleIdentifier) {
            _localizationLocale = Locale(identifier: localeIdentifier);
            return _localizationLocale
        } else {
            return nil
        }
    }
    
    func loadAllRegions(by globalalise: Globalalise) throws -> [Region] {
        
        func regions() throws -> [Region]  {
            
            func checkIfOnlyEnLocal() throws {
                if globalalise.availableLocales.count == 1 {
                    throw Region.Errors.onlyENLocale
                }
            }
            
            try checkIfOnlyEnLocal()
            
            
            var regionOfName = [String: Region]()
            
            try globalalise.availableLocales.filter{ $0 != globalalise.enLocale }.forEach({ locale in
                if let code = locale.regionCode, let regionName = globalalise.enLocale.localizedString(forRegionCode: code)?.localizedCapitalized {
                    if var region = regionOfName[regionName] {
                        region.append(locale)
                        regionOfName[regionName] = region
                    } else {
                        regionOfName[regionName] = Region(regionName, locale)
                    }
                } else {
                    throw Region.Errors.regionCodeEmpty
                }
            })
            
            return Array(regionOfName.values)
        }
        
        
        let regions = try regions()
        
        regions.forEach { region in
            print("Region:\(region.description)")
        }
        return regions
    }
    
    func clickOnRegion(_ region: Region) throws -> [LocalizedLanguage] {
        print("select Regin:\(region.name)")
        return try region.localizedLanguages()
    }
    
    func clickOnLocalizedLanguage(_ localizedLanguage: LocalizedLanguage) -> Locale {
        print("select localizedLanguage:\(localizedLanguage.name)")
        return localizedLanguage.locale
    }
    
    
    /// mutating change Self when invoke this method
    func switched(to locale: Locale) {
        print("switched to \(locale)")
        _localizationLocale = locale
        storage.set(locale.identifier, forKey: .selectedLocaleIdentifier)
        
        NotificationCenter.default.post(name: Globalalise.SwitchedToLocaleNotification.Name,
                                        object: nil,
                                        userInfo: [Globalalise.SwitchedToLocaleNotification.Key: locale])
    }
    
    
}


extension Locale {
    
    /// Returns the app's current locale.
    public static var currentOfApp: Locale? {
        SettingLAGManager.shared.localizationLocale()
    }
    
}
