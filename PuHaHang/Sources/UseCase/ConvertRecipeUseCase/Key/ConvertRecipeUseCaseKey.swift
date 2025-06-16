//
//  ConvertRecipeUseCaseKey.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Dependencies
import Foundation

private enum FetchConvertedPreviewUseCaseKey: DependencyKey {
    static let liveValue: FetchConvertedPreviewUseCase = LiveFetchConvertedPreviewUseCase(
        recipeConversionRepository: MockRecipeConversionRepository(),
        recipePreviewRepository: MockRecipePreviewRepository()
    )
}

extension DependencyValues {
    var fetchConvertedPreviewUseCase: FetchConvertedPreviewUseCase {
        get { self[FetchConvertedPreviewUseCaseKey.self] }
        set { self[FetchConvertedPreviewUseCaseKey.self] = newValue }
    }
}
