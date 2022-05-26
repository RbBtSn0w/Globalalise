//
//  LocalizedString.swift
//  Globalalise
//
//  Created by Snow.y.wu on 5/13/22.
//

import Foundation


fileprivate struct Detect {
    let tagValue = UUID().uuidString
    
    static var shared = Detect()
}

extension String {
    fileprivate func toBundle() -> Bundle?{
        Bundle.init(path: self)
    }
    
    /**
     Localization (l10n) is the process of adapting a product or service for use in specific countries or regions.
     
     Example:
     1. "hello".l10N(defaultValue: "123")
     2. "hello".l10N(tableName: "MyTable", bundle: .main)
     
     bundle.multicaseLocalizedString(forKey: self, defaultValue, tableName, comment)
     
     If key is nil and value is nil, returns an empty string.
     If key is nil and value is non-nil, returns value.
     If key is not found and value is nil or an empty string, returns key.
     If key is not found and value is non-nil and not empty, return value.
     
     - Parameters:
        - defaultValue: defaultValue description
        - tableName: tableName description
        - bundle: bundle description
        - comment: comment description
     - Returns: description
     */
    public func l10N(defaultValue: String? = nil, tableName: String? = nil, bundle: Bundle = Bundle.main, comment: String? = nil) -> String {
        return bundle.multicaseLocalizedString(forKey: self, defaultValue, tableName, comment)
    }
}

extension Bundle {
    
    /**
     Localization (l10n) is the process of adapting a product or service for use in specific countries or regions.
     Support multi case
        * localizedString
        * baseString
        * enString
     
     If key is nil and value is nil, returns an empty string.
     If key is nil and value is non-nil, returns value.
     If key is not found and value is nil or an empty string, returns key.
     If key is not found and value is non-nil and not empty, return value.
     
     - Parameters:
        - key: key description
        - defaultValue: defaultValue description
        - tableName: tableName description
        - comment: comment description
     - Returns: description
     */
    public func multicaseLocalizedString(forKey key: String, _ defaultValue: String?, _ tableName: String?, _ comment: String?) -> String {
        
        func lprojFilePath(of lprojFileName: String) -> String?{
            self.path(forResource: lprojFileName, ofType: "lproj")
        }
        
        func findAndDetectString(forKey key: String, tableName: String?, from bundle: Bundle) -> String? {
            /*
             If key is nil and value is nil, returns an empty string.
             If key is nil and value is non-nil, returns value.
             If key is not found and value is nil or an empty string, returns key.
             If key is not found and value is non-nil and not empty, return value.
             */
            let detectTagValue = Detect.shared.tagValue
            let  locString = bundle.localizedString(forKey: key, value: detectTagValue, table: tableName)
            if locString == detectTagValue {
                return nil
            }
            return locString
        }
        
        func localizedString(forKey key: String, table tableName: String?) -> String? {
            
            //First by identifiers. Examples of locale identifiers include "en_GB", "es_ES_PREEURO", and "zh-Hant_HK
            guard let locale = SettingLAGManager.shared.localizationLocale() else { return nil }
            
            if let bundle = lprojFilePath(of: locale.identifier)?.toBundle() {
                return findAndDetectString(forKey: key, tableName: tableName, from: bundle)
            } else {
                
                //Second by languageCode. Examples of language codes include "en", "es", and "zh".
                guard let localizationLanguageCode = locale.languageCode else { return nil }
                
                if let bundle = lprojFilePath(of: localizationLanguageCode)?.toBundle() {
                    return findAndDetectString(forKey: key, tableName: tableName, from: bundle)
                } else {
                    return nil
                }
            }
        }
        
        /**
         
         Using Base Internationalization
         
         Base internationalization separates user-facing strings from .storyboard and .xib files. It relieves localizers of the need to modify .storyboard and .xib files in Interface Builder. Instead, an app has just one set of .storyboard and .xib files where strings are in the development language—the language that you used to create the .storyboard and .xib files. These .storyboard and .xib files are called the base internationalization. When you export localizations, the development language strings are the source that is translated into multiple languages. When you import localizations, Xcode generates language-specific strings files for each .storyboard and .xib file. The strings files don’t appear in the project navigator until you import localizations or add languages.
         
         In Xcode 5 and later, base internationalization is enabled by default. If you have an older project, enable base internationalization before continuing, as described in Enabling Base Internationalization.
         
         - Parameters:
         - key: key description
         - tableName: tableName description
         - Returns: description
         */
        func baseString(forKey key: String, table tableName: String?) -> String? {
            
            guard let bundle = lprojFilePath(of: "Base")?.toBundle() else { return nil }
            
            return findAndDetectString(forKey: key, tableName: tableName, from: bundle)
        }
        
        
        /// iOS legancy path
        /// - Parameters:
        ///   - key: key description
        ///   - tableName: tableName description
        /// - Returns: description
        func enString(forKey key: String, table tableName: String?) -> String? {
            
            guard let bundle = lprojFilePath(of: "en")?.toBundle() else { return nil }
            
            return findAndDetectString(forKey: key, tableName: tableName, from: bundle)
        }
        
        
        var value = localizedString(forKey: key, table: tableName)
        
        if value == nil {
            value = baseString(forKey: key, table: tableName)
        }
        
        if value == nil {
            value = enString(forKey: key, table: tableName)
        }
        
        if value == nil {
            value = defaultValue
        }
        
        if value == nil {
            value = key
        }
        
        return value!
    }
}

