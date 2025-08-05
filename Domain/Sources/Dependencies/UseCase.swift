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

// MARK: - CookingOnboardingCheckUseCase DI

public enum CookingOnboardingCheckUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: CookingOnboardingCheckUseCase = EmptyCookingOnboardingCheckUseCase()
    #endif
}

public extension DependencyValues {
    var cookingOnboardingCheckUseCase: CookingOnboardingCheckUseCase {
        get { self[CookingOnboardingCheckUseCaseKey.self] }
        set { self[CookingOnboardingCheckUseCaseKey.self] = newValue }
    }
}

// MARK: - CookingOnboardingCompleteUseCase DI

public enum CookingOnboardingCompleteUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: CookingOnboardingCompleteUseCase = EmptyCookingOnboardingCompleteUseCase()
    #endif
}

public extension DependencyValues {
    var cookingOnboardingCompleteUseCase: CookingOnboardingCompleteUseCase {
        get { self[CookingOnboardingCompleteUseCaseKey.self] }
        set { self[CookingOnboardingCompleteUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchUILanguageUseCase DI

public enum FetchUILanguageUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchUILanguageUseCase = EmptyFetchUILanguageUseCase()
    #endif
}

public extension DependencyValues {
    var fetchUILanguageUseCase: FetchUILanguageUseCase {
        get { self[FetchUILanguageUseCaseKey.self] }
        set { self[FetchUILanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - SetUILanguageUseCase DI

public enum SetUILanguageUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: SetUILanguageUseCase = EmptySetUILanguageUseCase()
    #endif
}

public extension DependencyValues {
    var setUILanguageUseCase: SetUILanguageUseCase {
        get { self[SetUILanguageUseCaseKey.self] }
        set { self[SetUILanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchConversionLanguageUseCase DI

public enum FetchConversionLanguageUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: FetchConversionLanguageUseCase = EmptyFetchConversionLanguageUseCase()
    #endif
}

public extension DependencyValues {
    var fetchConversionLanguageUseCase: FetchConversionLanguageUseCase {
        get { self[FetchConversionLanguageUseCaseKey.self] }
        set {
            self[FetchConversionLanguageUseCaseKey.self] = newValue
        }
    }
}

// MARK: - SetConversionLanguageUseCase DI

public enum SetConversionLanguageUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: SetConversionLanguageUseCase = EmptySetConversionLanguageUseCase()
    #endif
}

public extension DependencyValues {
    var setConversionLanguageUseCase: SetConversionLanguageUseCase {
        get { self[SetConversionLanguageUseCaseKey.self] }
        set { self[SetConversionLanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchOnboardingImageUseCase DI

public enum FetchOnboardingImageUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: FetchOnboardingImageUseCase = EmptyFetchOnboardingImageUseCase()
    #endif
}

public extension DependencyValues {
    var fetchOnboardingImageUseCase: FetchOnboardingImageUseCase {
        get { self[FetchOnboardingImageUseCaseKey.self] }
        set { self[FetchOnboardingImageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchCompletedRecipeConversionIDsUseCase DI

public enum FetchCompletedRecipeConversionIDsUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: FetchCompletedRecipeConversionIDsUseCase = EmptyFetchCompletedRecipeConversionIDsUseCase()
    #endif
}

public extension DependencyValues {
    var fetchCompletedRecipeConversionIDsUseCase: FetchCompletedRecipeConversionIDsUseCase {
        get { self[FetchCompletedRecipeConversionIDsUseCaseKey.self] }
        set { self[FetchCompletedRecipeConversionIDsUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipeStateUseCase DI

public enum FetchRecipeStateUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: FetchRecipeStateUseCase = EmptyFetchRecipeStateUseCase()
    #endif
}

public extension DependencyValues {
    var fetchRecipeStateUseCase: FetchRecipeStateUseCase {
        get { self[FetchRecipeStateUseCaseKey.self] }
        set { self[FetchRecipeStateUseCaseKey.self] = newValue }
    }
}

// MARK: - DeleteRecipeUseCase DI

public enum DeleteRecipeUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: DeleteRecipeUseCase = EmptyDeleteRecipeUseCase()
    #endif
}

public extension DependencyValues {
    var deleteRecipeUseCase: DeleteRecipeUseCase {
        get { self[DeleteRecipeUseCaseKey.self] }
        set { self[DeleteRecipeUseCaseKey.self] = newValue }
    }
}

// MARK: - ClearRecipePreviewCacheUseCase DI

public enum ClearRecipePreviewCacheUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static var testValue: ClearRecipePreviewCacheUseCase = EmptyClearRecipePreviewCacheUseCase()
    #endif
}

public extension DependencyValues {
    var clearRecipePreviewCacheUseCase: ClearRecipePreviewCacheUseCase {
        get { self[ClearRecipePreviewCacheUseCaseKey.self] }
        set { self[ClearRecipePreviewCacheUseCaseKey.self] = newValue }
    }
}
