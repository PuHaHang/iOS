//
//  SetConversionLanguageUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/24/25.
//

import Foundation

public struct SetConversionLanguageUseCaseImpl: SetConversionLanguageUseCase {
    private let languageRepository: LanguageRepository
    
    public init(languageRepository: LanguageRepository) {
        self.languageRepository = languageRepository
    }
    
    public func execute(_ language: String) {
        languageRepository.setConversionLanguage(language)
    }
}
