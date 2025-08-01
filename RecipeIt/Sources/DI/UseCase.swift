//
//  UseCase.swift
//  PuHaHang
//
//  Created by 디해 on 7/2/25.
//

import Dependencies
import Foundation
import Domain

extension IntroUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
}

extension FetchConvertedRecipeIDUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchConvertedRecipeIDUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        return FetchConvertedRecipeIDUseCaseImpl(recipeConversionRepository: recipeConversionRepository)
    }()
}

extension FetchRecipeDetailUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipeDetailUseCase = {
        @Dependency(\.recipeDetailRepository) var recipeDetailRepository
        return FetchRecipeDetailUseCaseImpl(recipeDetailRepository: recipeDetailRepository)
    }()
}

extension FetchRecipePreviewUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipePreviewUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
}

extension FetchRecipePreviewsUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchRecipePreviewsUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewsUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
}

extension LaunchOnboardingCheckUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any LaunchOnboardingCheckUseCase = {
        @Dependency(\.onboardingRepository) var onboardingRepository
        return LaunchOnboardingCheckUseCaseImpl(onboardingRepository: onboardingRepository)
    }()
}

extension LaunchOnboardingCompleteUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any LaunchOnboardingCompleteUseCase = {
        @Dependency(\.onboardingRepository) var onboardingRepository
        return LaunchOnboardingCompleteUseCaseImpl(onboardingRepository: onboardingRepository)
    }()
}

extension CookingOnboardingCheckUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any CookingOnboardingCheckUseCase = {
        @Dependency(\.onboardingRepository) var onboardingRepository
        return CookingOnboardingCheckUseCaseImpl(onboardingRepository: onboardingRepository)
    }()
}

extension CookingOnboardingCompleteUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any CookingOnboardingCompleteUseCase = {
        @Dependency(\.onboardingRepository) var onboardingRepository
        return CookingOnboardingCompleteUseCaseImpl(onboardingRepository: onboardingRepository)
    }()
}

extension FetchUILanguageUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchUILanguageUseCase = {
        @Dependency(\.languageRepository) var languageRepository
        return FetchUILanguageUseCaseImpl(languageRepository: languageRepository)
    }()
}

extension SetUILanguageUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any SetUILanguageUseCase = {
        @Dependency(\.languageRepository) var languageRepository
        return SetUILanguageUseCaseImpl(languageRepository: languageRepository)
    }()
}

extension FetchConversionLanguageUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchConversionLanguageUseCase = {
        @Dependency(\.languageRepository) var languageRepository
        return FetchConversionLanguageUseCaseImpl(languageRepository: languageRepository)
    }()
}

extension SetConversionLanguageUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any SetConversionLanguageUseCase = {
        @Dependency(\.languageRepository) var languageRepository
        return SetConversionLanguageUseCaseImpl(languageRepository: languageRepository)
    }()
}

extension FetchOnboardingImageUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchOnboardingImageUseCase = {
        @Dependency(\.onboardingRepository) var onboardingRepository
        return FetchOnboardingImageUseCaseImpl(onboardingRepository: onboardingRepository)
    }()
}

extension FetchCompletedRecipeConversionIDsUseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any FetchCompletedRecipeConversionIDsUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        return FetchCompletedRecipeConversionIDsUseCaseImpl(recipeConversionRepository: recipeConversionRepository)
    }()
}

extension FetchRecipeStateUseCaseKey: @retroactive DependencyKey {
    public static var liveValue: any FetchRecipeStateUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        return FetchRecipeStateUseCaseImpl(recipeConversionRepository: recipeConversionRepository)
    }()
}
