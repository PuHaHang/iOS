//
//  FetchRecipeDetailUseCaseKey.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Dependencies
import Foundation

private enum FetchRecipeDetailUseCaseKey: DependencyKey {
    static let liveValue: FetchRecipeDetailUseCase = LiveFetchRecipeDetailUseCase(recipeDetailRepository: RemoteRecipeDetailRepository(dataSource: RecipeDataSourceImpl()))
}

extension DependencyValues {
    var fetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
        get { self[FetchRecipeDetailUseCaseKey.self] }
        set { self[FetchRecipeDetailUseCaseKey.self] = newValue }
    }
}
