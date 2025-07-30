//
//  EmptyLanguageDataSource.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public struct EmptyLanguageDataSource: LanguageDataSource {
    public func fetchUILanguage() -> String? {
        throwUnimplemented()
    }
    
    public func setUILanguage(_ language: String) {
        throwUnimplemented()
    }
    
    public func fetchConversionLanguage() -> String? {
        throwUnimplemented()
    }
    
    public func setConversionLanguage(_ language: String) {
        throwUnimplemented()
    }
}
