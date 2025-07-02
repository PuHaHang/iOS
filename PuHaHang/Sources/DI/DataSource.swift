//
//  DataSource.swift
//  PuHaHang
//
//  Created by Jongchan Kim on 6/22/25.
//

import Foundation
import Data
import Dependencies

// MARK: - VersionDataSource DI

private enum VersionDataSourceKey: DependencyKey {
    static let liveValue: VersionDataSource = VersionDataSourceImpl()
    
    #if DEBUG
    static let testValue: VersionDataSource = MockVersionDataSourceImpl()
    #endif
}

extension DependencyValues {
    var versionDataSource: VersionDataSource {
        get { self[VersionDataSourceKey.self] }
        set { self[VersionDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipeDataSource DI

private enum RecipeDataSourceKey: DependencyKey {
    static let liveValue: RecipeDataSource = RecipeDataSourceImpl()
    
    #if DEBUG
    static let testValue: RecipeDataSource = RecipeDataSourceImpl()
    #endif
}

extension DependencyValues {
    var recipeDataSource: RecipeDataSource {
        get { self[RecipeDataSourceKey.self] }
        set { self[RecipeDataSourceKey.self] = newValue }
    }
}

// MARK: - RecipePreviewDataSource DI

private enum RecipePreviewDataSourceKey: DependencyKey {
    static let liveValue: RecipePreviewDataSource = RecipePreviewDataSourceImpl()
    
    #if DEBUG
    static let testValue: RecipePreviewDataSource = RecipePreviewDataSourceImpl()
    #endif
}

extension DependencyValues {
    var recipePreviewDataSource: RecipePreviewDataSource {
        get { self[RecipePreviewDataSourceKey.self] }
        set { self[RecipePreviewDataSourceKey.self] = newValue }
    }
}
