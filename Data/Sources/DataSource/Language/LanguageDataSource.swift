//
//  LanguageDataSource.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public protocol LanguageDataSource {
    func fetchUILanguage() -> String?
    func setUILanguage(_ language: String)
    func fetchConversionLanguage() -> String?
    func setConversionLanguage(_ language: String)
}
