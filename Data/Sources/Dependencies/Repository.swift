//
//  Repository.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Domain
import Dependencies

// MARK: - IntroRepository DI

public enum IntroRepositoryKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: IntroRepository = EmptyIntroRepository()
    #endif
}

public extension DependencyValues {
    var introRepository: IntroRepository {
        get { self[IntroRepositoryKey.self] }
        set { self[IntroRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipeConversionRepository DI

public enum RecipeConversionRepositoryKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: RecipeConversionRepository = EmptyRecipeConversionRepository()
    #endif
}

public extension DependencyValues {
    var recipeConversionRepository: RecipeConversionRepository {
        get { self[RecipeConversionRepositoryKey.self] }
        set { self[RecipeConversionRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipeDetailRepository DI

public enum RecipeDetailRepositoryKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: RecipeDetailRepository = EmptyRecipeDetailRepository()
    #endif
}

public extension DependencyValues {
    var recipeDetailRepository: RecipeDetailRepository {
        get { self[RecipeDetailRepositoryKey.self] }
        set { self[RecipeDetailRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipePreviewRepository DI

public enum RecipePreviewRepositoryKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: RecipePreviewRepository = EmptyRecipePreviewRepository()
    #endif
}

public extension DependencyValues {
    var recipePreviewRepository: RecipePreviewRepository {
        get { self[RecipePreviewRepositoryKey.self] }
        set { self[RecipePreviewRepositoryKey.self] = newValue }
    }
}

// MARK: - OnboardingRepository DI

public enum OnboardingRepositoryKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: OnboardingRepository = EmptyOnboardingRepository()
    #endif
}

public extension DependencyValues {
    var onboardingRepository: OnboardingRepository {
        get { self[OnboardingRepositoryKey.self] }
        set { self[OnboardingRepositoryKey.self] = newValue }
    }
}
