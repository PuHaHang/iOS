//
//  FetchRecipePreviewUseCaseKey.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Dependencies
import Foundation

private enum FetchRecipePreviewsUseCaseKey: DependencyKey {
    static let liveValue: FetchRecipePreviewsUseCase = LiveFetchRecipePreviewsUseCase(
        recipePreviewRepository: MockRecipePreviewRepository()
    )
}

extension DependencyValues {
    var fetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
        get { self[FetchRecipePreviewsUseCaseKey.self] }
        set { self[FetchRecipePreviewsUseCaseKey.self] = newValue }
    }
}
