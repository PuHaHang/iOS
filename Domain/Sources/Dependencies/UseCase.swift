//
//  UseCase.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//
import Foundation
import Dependencies

// MARK: - IntroUseCase DI

public enum IntroUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: any IntroUseCase = EmptyIntroUseCase()
    #endif
}

public extension DependencyValues {
    var introUseCase: any IntroUseCase {
        get { self[IntroUseCaseKey.self] }
        set { self[IntroUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchConvertedPreviewUseCase DI

public enum FetchConvertedRecipeIDUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchConvertedRecipeIDUseCase = EmptyFetchConvertedPreviewUseCase()
    #endif
}

public extension DependencyValues {
    var fetchConvertedRecipeIDUseCase: FetchConvertedRecipeIDUseCase {
        get { self[FetchConvertedRecipeIDUseCaseKey.self] }
        set { self[FetchConvertedRecipeIDUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipeDetailUseCase DI

public enum FetchRecipeDetailUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchRecipeDetailUseCase = EmptyFetchRecipeDetailUseCase()
    #endif
}

public extension DependencyValues {
    var fetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
        get { self[FetchRecipeDetailUseCaseKey.self] }
        set { self[FetchRecipeDetailUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipePreviewUseCase DI

public enum FetchRecipePreviewUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchRecipePreviewUseCase = EmptyFetchRecipePreviewUseCase()
    #endif
}

public extension DependencyValues {
    var fetchRecipePreviewUseCase: FetchRecipePreviewUseCase {
        get { self[FetchRecipePreviewUseCaseKey.self] }
        set { self[FetchRecipePreviewUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipePreviewUseCase DI

public enum FetchRecipePreviewsUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchRecipePreviewsUseCase = EmptyFetchRecipePreviewsUseCase()
    #endif
}

public extension DependencyValues {
    var fetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
        get { self[FetchRecipePreviewsUseCaseKey.self] }
        set { self[FetchRecipePreviewsUseCaseKey.self] = newValue }
    }
}

// MARK: - LaunchOnboardingCheckUseCase DI

public enum LaunchOnboardingCheckUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: LaunchOnboardingCheckUseCase = EmptyLaunchOnboardingCheckUseCase()
    #endif
}

public extension DependencyValues {
    var launchOnboardingCheckUseCase: LaunchOnboardingCheckUseCase {
        get { self[LaunchOnboardingCheckUseCaseKey.self] }
        set { self[LaunchOnboardingCheckUseCaseKey.self] = newValue }
    }
}

// MARK: - LaunchOnboardingCompleteUseCase DI

public enum LaunchOnboardingCompleteUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: LaunchOnboardingCompleteUseCase = EmptyLaunchOnboardingCompleteUseCase()
    #endif
}

public extension DependencyValues {
    var launchOnboardingCompleteUseCase: LaunchOnboardingCompleteUseCase {
        get { self[LaunchOnboardingCompleteUseCaseKey.self] }
        set { self[LaunchOnboardingCompleteUseCaseKey.self] = newValue }
    }
}
