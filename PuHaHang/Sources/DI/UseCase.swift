//
//  UseCase.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//
import Foundation
import Domain
import Dependencies

// MARK: - IntroUseCase DI

private enum IntroUseCaseKey: DependencyKey {
    static let liveValue: IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
    
    #if DEBUG
    static let testValue: IntroUseCase = {
        @Dependency(\.introRepository) var introRepository
        return IntroUseCaseImpl(introRepository: introRepository)
    }()
    #endif
}

extension DependencyValues {
    var introUseCase: IntroUseCase {
        get { self[IntroUseCaseKey.self] }
        set { self[IntroUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchConvertedPreviewUseCase DI

private enum FetchConvertedPreviewUseCaseKey: DependencyKey {
    static let liveValue: FetchConvertedPreviewUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchConvertedPreviewUseCaseImpl(
            recipeConversionRepository: recipeConversionRepository,
            recipePreviewRepository: recipePreviewRepository
        )
    }()
    
    #if DEBUG
    static let testValue: FetchConvertedPreviewUseCase = {
        @Dependency(\.recipeConversionRepository) var recipeConversionRepository
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchConvertedPreviewUseCaseImpl(
            recipeConversionRepository: recipeConversionRepository,
            recipePreviewRepository: recipePreviewRepository
        )
    }()
    #endif
}

extension DependencyValues {
    var fetchConvertedPreviewUseCase: FetchConvertedPreviewUseCase {
        get { self[FetchConvertedPreviewUseCaseKey.self] }
        set { self[FetchConvertedPreviewUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipeDetailUseCase DI

private enum FetchRecipeDetailUseCaseKey: DependencyKey {
    static let liveValue: FetchRecipeDetailUseCase = {
        @Dependency(\.recipeDetailRepository) var recipeDetailRepository
        return FetchRecipeDetailUseCaseImpl(recipeDetailRepository: recipeDetailRepository)
    }()
    
    #if DEBUG
    static let testValue: FetchRecipeDetailUseCase = {
        @Dependency(\.recipeDetailRepository) var recipeDetailRepository
        return FetchRecipeDetailUseCaseImpl(recipeDetailRepository: recipeDetailRepository)
    }()
    #endif
}

extension DependencyValues {
    var fetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
        get { self[FetchRecipeDetailUseCaseKey.self] }
        set { self[FetchRecipeDetailUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipePreviewUseCase DI

private enum FetchRecipePreviewsUseCaseKey: DependencyKey {
    static let liveValue: FetchRecipePreviewsUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewsUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
    
    #if DEBUG
    static let testValue: FetchRecipePreviewsUseCase = {
        @Dependency(\.recipePreviewRepository) var recipePreviewRepository
        return FetchRecipePreviewsUseCaseImpl(recipePreviewRepository: recipePreviewRepository)
    }()
    #endif
}

extension DependencyValues {
    var fetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
        get { self[FetchRecipePreviewsUseCaseKey.self] }
        set { self[FetchRecipePreviewsUseCaseKey.self] = newValue }
    }
}
