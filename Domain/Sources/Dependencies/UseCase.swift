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
    public static let testValue: any IntroUseCase = EmptyIntroUseCase()
}

public extension DependencyValues {
    var introUseCase: any IntroUseCase {
        get { self[IntroUseCaseKey.self] }
        set { self[IntroUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchConvertedPreviewUseCase DI

public enum FetchConvertedRecipeIDUseCaseKey: TestDependencyKey {
    public static let testValue: FetchConvertedRecipeIDUseCase = EmptyFetchConvertedPreviewUseCase()
}

public extension DependencyValues {
    var fetchConvertedRecipeIDUseCase: FetchConvertedRecipeIDUseCase {
        get { self[FetchConvertedRecipeIDUseCaseKey.self] }
        set { self[FetchConvertedRecipeIDUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipeDetailUseCase DI

public enum FetchRecipeDetailUseCaseKey: TestDependencyKey {
    public static let testValue: FetchRecipeDetailUseCase = EmptyFetchRecipeDetailUseCase()
}

public extension DependencyValues {
    var fetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
        get { self[FetchRecipeDetailUseCaseKey.self] }
        set { self[FetchRecipeDetailUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipePreviewUseCase DI

public enum FetchRecipePreviewUseCaseKey: TestDependencyKey {
    public static let testValue: FetchRecipePreviewUseCase = EmptyFetchRecipePreviewUseCase()
}

public extension DependencyValues {
    var fetchRecipePreviewUseCase: FetchRecipePreviewUseCase {
        get { self[FetchRecipePreviewUseCaseKey.self] }
        set { self[FetchRecipePreviewUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipePreviewUseCase DI

public enum FetchRecipePreviewsUseCaseKey: TestDependencyKey {
    public static let testValue: FetchRecipePreviewsUseCase = EmptyFetchRecipePreviewsUseCase()
}

public extension DependencyValues {
    var fetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
        get { self[FetchRecipePreviewsUseCaseKey.self] }
        set { self[FetchRecipePreviewsUseCaseKey.self] = newValue }
    }
}

// MARK: - LaunchOnboardingCheckUseCase DI

public enum LaunchOnboardingCheckUseCaseKey: TestDependencyKey {
    public static let testValue: LaunchOnboardingCheckUseCase = EmptyLaunchOnboardingCheckUseCase()
}

public extension DependencyValues {
    var launchOnboardingCheckUseCase: LaunchOnboardingCheckUseCase {
        get { self[LaunchOnboardingCheckUseCaseKey.self] }
        set { self[LaunchOnboardingCheckUseCaseKey.self] = newValue }
    }
}

// MARK: - LaunchOnboardingCompleteUseCase DI

public enum LaunchOnboardingCompleteUseCaseKey: TestDependencyKey {
    public static let testValue: LaunchOnboardingCompleteUseCase = EmptyLaunchOnboardingCompleteUseCase()
}

public extension DependencyValues {
    var launchOnboardingCompleteUseCase: LaunchOnboardingCompleteUseCase {
        get { self[LaunchOnboardingCompleteUseCaseKey.self] }
        set { self[LaunchOnboardingCompleteUseCaseKey.self] = newValue }
    }
}

// MARK: - CookingOnboardingCheckUseCase DI

public enum CookingOnboardingCheckUseCaseKey: TestDependencyKey {
    public static let testValue: CookingOnboardingCheckUseCase = EmptyCookingOnboardingCheckUseCase()
}

public extension DependencyValues {
    var cookingOnboardingCheckUseCase: CookingOnboardingCheckUseCase {
        get { self[CookingOnboardingCheckUseCaseKey.self] }
        set { self[CookingOnboardingCheckUseCaseKey.self] = newValue }
    }
}

// MARK: - CookingOnboardingCompleteUseCase DI

public enum CookingOnboardingCompleteUseCaseKey: TestDependencyKey {
    public static let testValue: CookingOnboardingCompleteUseCase = EmptyCookingOnboardingCompleteUseCase()
}

public extension DependencyValues {
    var cookingOnboardingCompleteUseCase: CookingOnboardingCompleteUseCase {
        get { self[CookingOnboardingCompleteUseCaseKey.self] }
        set { self[CookingOnboardingCompleteUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchUILanguageUseCase DI

public enum FetchUILanguageUseCaseKey: TestDependencyKey {
    public static let testValue: FetchUILanguageUseCase = EmptyFetchUILanguageUseCase()
}

public extension DependencyValues {
    var fetchUILanguageUseCase: FetchUILanguageUseCase {
        get { self[FetchUILanguageUseCaseKey.self] }
        set { self[FetchUILanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - SetUILanguageUseCase DI

public enum SetUILanguageUseCaseKey: TestDependencyKey {
    public static var testValue: SetUILanguageUseCase = EmptySetUILanguageUseCase()
}

public extension DependencyValues {
    var setUILanguageUseCase: SetUILanguageUseCase {
        get { self[SetUILanguageUseCaseKey.self] }
        set { self[SetUILanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchConversionLanguageUseCase DI

public enum FetchConversionLanguageUseCaseKey: TestDependencyKey {
    public static var testValue: FetchConversionLanguageUseCase = EmptyFetchConversionLanguageUseCase()
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
    public static var testValue: SetConversionLanguageUseCase = EmptySetConversionLanguageUseCase()
}

public extension DependencyValues {
    var setConversionLanguageUseCase: SetConversionLanguageUseCase {
        get { self[SetConversionLanguageUseCaseKey.self] }
        set { self[SetConversionLanguageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchOnboardingImageUseCase DI

public enum FetchOnboardingImageUseCaseKey: TestDependencyKey {
    public static var testValue: FetchOnboardingImageUseCase = EmptyFetchOnboardingImageUseCase()
}

public extension DependencyValues {
    var fetchOnboardingImageUseCase: FetchOnboardingImageUseCase {
        get { self[FetchOnboardingImageUseCaseKey.self] }
        set { self[FetchOnboardingImageUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchCompletedRecipeConversionIDsUseCase DI

public enum FetchCompletedRecipeConversionIDsUseCaseKey: TestDependencyKey {
    public static var testValue: FetchCompletedRecipeConversionIDsUseCase = EmptyFetchCompletedRecipeConversionIDsUseCase()
}

public extension DependencyValues {
    var fetchCompletedRecipeConversionIDsUseCase: FetchCompletedRecipeConversionIDsUseCase {
        get { self[FetchCompletedRecipeConversionIDsUseCaseKey.self] }
        set { self[FetchCompletedRecipeConversionIDsUseCaseKey.self] = newValue }
    }
}

// MARK: - FetchRecipeStateUseCase DI

public enum FetchRecipeStateUseCaseKey: TestDependencyKey {
    public static var testValue: FetchRecipeStateUseCase = EmptyFetchRecipeStateUseCase()
}

public extension DependencyValues {
    var fetchRecipeStateUseCase: FetchRecipeStateUseCase {
        get { self[FetchRecipeStateUseCaseKey.self] }
        set { self[FetchRecipeStateUseCaseKey.self] = newValue }
    }
}

// MARK: - DeleteRecipeUseCase DI

public enum DeleteRecipeUseCaseKey: TestDependencyKey {
    public static var testValue: DeleteRecipeUseCase = EmptyDeleteRecipeUseCase()
}

public extension DependencyValues {
    var deleteRecipeUseCase: DeleteRecipeUseCase {
        get { self[DeleteRecipeUseCaseKey.self] }
        set { self[DeleteRecipeUseCaseKey.self] = newValue }
    }
}

// MARK: - ClearRecipePreviewCacheUseCase DI

public enum ClearRecipePreviewCacheUseCaseKey: TestDependencyKey {
    public static var testValue: ClearRecipePreviewCacheUseCase = EmptyClearRecipePreviewCacheUseCase()
}

public extension DependencyValues {
    var clearRecipePreviewCacheUseCase: ClearRecipePreviewCacheUseCase {
        get { self[ClearRecipePreviewCacheUseCaseKey.self] }
        set { self[ClearRecipePreviewCacheUseCaseKey.self] = newValue }
    }
}
