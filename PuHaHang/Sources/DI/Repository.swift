//
//  Repository.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Domain
import Data
import Dependencies

// MARK: - IntroRepository DI

public enum IntroRepositoryKey: DependencyKey {
    public static let liveValue: IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
    
    #if DEBUG
    public static let testValue: IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
    #endif
}

public extension DependencyValues {
    var introRepository: IntroRepository {
        get { self[IntroRepositoryKey.self] }
        set { self[IntroRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipeConversionRepository DI

private enum RecipeConversionRepositoryKey: DependencyKey {
    static let liveValue: RecipeConversionRepository = {
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeConversionRepositoryImpl(dataSource: recipeDataSource)
    }()
    
    #if DEBUG
    static let testValue: RecipeConversionRepository = MockRecipeConversionRepositoryImpl()
    #endif
}

extension DependencyValues {
    var recipeConversionRepository: RecipeConversionRepository {
        get { self[RecipeConversionRepositoryKey.self] }
        set { self[RecipeConversionRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipeDetailRepository DI

private enum RecipeDetailRepositoryKey: DependencyKey {
    static let liveValue: RecipeDetailRepository = {
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeDetailRepositoryImpl(dataSource: recipeDataSource)
    }()
    
    #if DEBUG
    static let testValue: RecipeDetailRepository = MockRecipeDetailRepositoryImpl()
    #endif
}

extension DependencyValues {
    var recipeDetailRepository: RecipeDetailRepository {
        get { self[RecipeDetailRepositoryKey.self] }
        set { self[RecipeDetailRepositoryKey.self] = newValue }
    }
}

// MARK: - RecipePreviewRepository DI

private enum RecipePreviewRepositoryKey: DependencyKey {
    static let liveValue: RecipePreviewRepository = {
        @Dependency(\.recipePreviewDataSource) var recipePreviewDataSource
        return RecipePreviewRepositoryImpl(dataSource: recipePreviewDataSource)
    }()
    
    #if DEBUG
    static let testValue: RecipePreviewRepository = MockRecipePreviewRepositoryImpl()
    #endif
}

extension DependencyValues {
    var recipePreviewRepository: RecipePreviewRepository {
        get { self[RecipePreviewRepositoryKey.self] }
        set { self[RecipePreviewRepositoryKey.self] = newValue }
    }
}
