//
//  LanguageRepository.swift
//  Domain
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public protocol LanguageRepository {
    func getUILanguage() -> String?
    func setUILanguage(_ language: String)
    func getConversionLanguage() -> String?
    func setConversionLanguage(_ language: String)
}
