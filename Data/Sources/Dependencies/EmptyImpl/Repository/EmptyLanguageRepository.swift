//
//  EmptyLanguageRepository.swift
//  Data
//
//  Created by 디해 on 7/24/25.
//

import Domain
import Foundation

struct EmptyLanguageRepository: LanguageRepository {
    func getUILanguage() -> String? {
        throwUnimplemented()
    }
    
    func setUILanguage(_ language: String) {
        throwUnimplemented()
    }
    
    func getConversionLanguage() -> String? {
        throwUnimplemented()
    }
    
    func setConversionLanguage(_ language: String) {
        throwUnimplemented()
    }
}
