//
//  protocol.swift
//  Globalalise
//
//  Created by Snow.y.wu on 5/1/22.
//

import Foundation

public protocol GlobalaliseProtocol{
    
    /// Only en env formate, it's default
    var enLocale: Locale { get }
    
    /// Array of NSLocale objects. Always has at least one locale.
    var availableLocales: [Locale] { get }
}

public protocol SettingLARProtocol {
    
    
    /// throws Region.Errors
    /// - Returns: List [Region]
    func loadAllRegions() throws -> [Region]
    
    
    /// throws LocalizedLanguage.Errors
    /// - Returns: List [LocalizedLanguage]
    func clickOnRegion(_ region: Region) throws -> [LocalizedLanguage]
    
    func clickOnLocalizedLanguage(_ localizedLanguage: LocalizedLanguage) -> Locale
    
    /// 将当前APP设置切换到指定 locale, 同时会发送一个通知出来.Globalalise.SwitchedToLocaleNotification, Object为Locale
    /// - Parameter locale: 输入的local 必须是有效数据, 且是从Globalalise来的
    func switched(to locale: Locale)
    
    /// Currently selected localization locale.
    /// - Returns: Locale is free brigth to NSLocale
    func localizationLocale() -> Locale?
}
