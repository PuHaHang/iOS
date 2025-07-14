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

public enum FetchConvertedPreviewUseCaseKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: FetchConvertedPreviewUseCase = EmptyFetchConvertedPreviewUseCase()
    #endif
}

public extension DependencyValues {
    var fetchConvertedPreviewUseCase: FetchConvertedPreviewUseCase {
        get { self[FetchConvertedPreviewUseCaseKey.self] }
        set { self[FetchConvertedPreviewUseCaseKey.self] = newValue }
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
