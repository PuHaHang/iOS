//
//  Repository.swift
//  PuHaHang
//
//  Created by 디해 on 7/2/25.
//

import Dependencies
import Foundation
import Data
import Domain

private func shouldUseMockRepository() -> Bool {
    #if USE_MOCK_REPOSITORY
    return true
    #else
    return false
    #endif
}

extension IntroRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
}

extension RecipeConversionRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipeConversionRepository = {
        if shouldUseMockRepository() {
            return MockRecipeConversionRepositoryImpl()
        }
        
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeConversionRepositoryImpl(dataSource: recipeDataSource)
    }()
}

extension RecipeDetailRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipeDetailRepository = {
        if shouldUseMockRepository() {
            return MockRecipeDetailRepositoryImpl()
        }
        
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeDetailRepositoryImpl(dataSource: recipeDataSource)
    }()
}

extension RecipePreviewRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipePreviewRepository = {
        if shouldUseMockRepository() {
            return MockRecipePreviewRepositoryImpl()
        }
        
        @Dependency(\.recipePreviewDataSource) var recipePreviewDataSource
        return RecipePreviewRepositoryImpl(dataSource: recipePreviewDataSource)
    }()
}

extension OnboardingRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any OnboardingRepository = {
        if shouldUseMockRepository() {
            return MockOnboardingRepositoryImpl()
        }
        
        @Dependency(\.onboardingDataSource) var onboardingDataSource
        return OnboardingRepositoryImpl(dataSource: onboardingDataSource)
    }()
}

extension LanguageRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any LanguageRepository = {
        @Dependency(\.languageDataSource) var languageDataSource
        return LanguageRepositoryImpl(dataSource: languageDataSource)
    }()
}
