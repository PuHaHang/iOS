//
//  Repository.swift
//  PuHaHang
//
//  Created by 디해 on 7/2/25.
//

import Dependencies
import Foundation
import Data
import Domain

extension IntroRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any IntroRepository = {
        @Dependency(\.versionDataSource) var versionDataSource
        return IntroRepositoryImpl(dataSource: versionDataSource)
    }()
}

extension RecipeConversionRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipeConversionRepository = {
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeConversionRepositoryImpl(dataSource: recipeDataSource)
    }()
}

extension RecipeDetailRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipeDetailRepository =  {
        @Dependency(\.recipeDataSource) var recipeDataSource
        return RecipeDetailRepositoryImpl(dataSource: recipeDataSource)
    }()
}

extension RecipePreviewRepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any RecipePreviewRepository = {
        @Dependency(\.recipePreviewDataSource) var recipePreviewDataSource
        return RecipePreviewRepositoryImpl(dataSource: recipePreviewDataSource)
    }()
}
