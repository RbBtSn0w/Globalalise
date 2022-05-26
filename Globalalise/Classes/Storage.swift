//
//  Storage.swift
//  Globalalise
//
//  Created by Snow.y.wu on 4/21/22.
//

import Foundation



struct Storage {
    
    enum DefaultsKeys: String {
        case selectedLocaleIdentifier = "SettingLAGSelectedLocaleIdentifier"
    }
    
    // MARK: - Private properties
    
    private var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    // MARK: - Methods
    
    func string(forKey key: DefaultsKeys) -> String? {
        defaults.string(forKey: key.rawValue)
    }
    
    func set(_ value: String, forKey: DefaultsKeys) {
        defaults.set(value, forKey: forKey.rawValue)
    }
}
