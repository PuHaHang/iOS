//
//  LanguageDataSourceImpl.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public struct LanguageDataSourceImpl: LanguageDataSource {
    private let uiLanguageKey = "ui_language"
    private let conversionLanguageKey = "conversion_language"
    
    public init() {}
    
    public func fetchUILanguage() -> String? {
        UserDefaults.standard.string(forKey: uiLanguageKey)
    }
    
    public func setUILanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: uiLanguageKey)
    }
    
    public func fetchConversionLanguage() -> String? {
        UserDefaults.standard.string(forKey: conversionLanguageKey)
    }
    
    public func setConversionLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: conversionLanguageKey)
    }
}
