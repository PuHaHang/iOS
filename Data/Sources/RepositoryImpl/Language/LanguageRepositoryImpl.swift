//
//  LanguageRepositoryImpl.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Domain
import Foundation

public struct LanguageRepositoryImpl: LanguageRepository {
    private let dataSource: LanguageDataSource
    
    public init(dataSource: LanguageDataSource) {
        self.dataSource = dataSource
    }
    
    public func getUILanguage() -> String? {
        dataSource.fetchUILanguage()
    }
    
    public func setUILanguage(_ language: String) {
        dataSource.setUILanguage(language)
    }
    
    public func getConversionLanguage() -> String? {
        dataSource.fetchConversionLanguage()
    }
    
    public func setConversionLanguage(_ language: String) {
        dataSource.setConversionLanguage(language)
    }
}
