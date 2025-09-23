//
//  DataSource.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Dependencies

// MARK: - VersionDataSource DI

public enum VersionDataSourceKey: TestDependencyKey {
    public static let testValue: VersionDataSource = EmptyVersionDataSource()
}

public extension DependencyValues {
    var versionDataSource: VersionDataSource {
        get { self[VersionDataSourceKey.self] }
        set { self[VersionDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipeDataSource DI

public enum RecipeDataSourceKey: TestDependencyKey {
    public static let testValue: RecipeDataSource = EmptyRecipeDataSource()
}

public extension DependencyValues {
    var recipeDataSource: RecipeDataSource {
        get { self[RecipeDataSourceKey.self] }
        set { self[RecipeDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipePreviewDataSource DI

public enum RecipePreviewDataSourceKey: TestDependencyKey {
    public static let testValue: RecipePreviewDataSource = EmptyRecipePreviewDataSource()
}

public extension DependencyValues {
    var recipePreviewDataSource: RecipePreviewDataSource {
        get { self[RecipePreviewDataSourceKey.self] }
        set { self[RecipePreviewDataSourceKey.self] = newValue }
    }
}

// MARK: - OnboardingDataSource DI

public enum OnboardingDataSourceKey: TestDependencyKey {
    public static let testValue: OnboardingDataSource = EmptyOnboardingDataSource()
}

public extension DependencyValues {
    var onboardingDataSource: OnboardingDataSource {
        get { self[OnboardingDataSourceKey.self] }
        set { self[OnboardingDataSourceKey.self] = newValue }
    }
}

// MARK: - LanguageDataSource

public enum LanguageDataSourceKey: TestDependencyKey {
    public static let testValue: LanguageDataSource = EmptyLanguageDataSource()
}

public extension DependencyValues {
    var languageDataSource: LanguageDataSource {
        get { self[LanguageDataSourceKey.self] }
        set { self[LanguageDataSourceKey.self] = newValue }
    }
}
