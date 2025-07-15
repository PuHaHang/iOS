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
    #if DEBUG
    public static let testValue: VersionDataSource = EmptyVersionDataSource()
    #endif
}

public extension DependencyValues {
    var versionDataSource: VersionDataSource {
        get { self[VersionDataSourceKey.self] }
        set { self[VersionDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipeDataSource DI

public enum RecipeDataSourceKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: RecipeDataSource = EmptyRecipeDataSource()
    #endif
}

public extension DependencyValues {
    var recipeDataSource: RecipeDataSource {
        get { self[RecipeDataSourceKey.self] }
        set { self[RecipeDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipePreviewDataSource DI

public enum RecipePreviewDataSourceKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: RecipePreviewDataSource = EmptyRecipePreviewDataSource()
    #endif
}

public extension DependencyValues {
    var recipePreviewDataSource: RecipePreviewDataSource {
        get { self[RecipePreviewDataSourceKey.self] }
        set { self[RecipePreviewDataSourceKey.self] = newValue }
    }
}

// MARK: - OnboardingDataSource DI

public enum OnboardingDataSourceKey: TestDependencyKey {
    #if DEBUG
    public static let testValue: OnboardingDataSource = EmptyOnboardingDataSource()
    #endif
}

public extension DependencyValues {
    var onboardingDataSource: OnboardingDataSource {
        get { self[OnboardingDataSourceKey.self] }
        set { self[OnboardingDataSourceKey.self] = newValue }
    }
}
