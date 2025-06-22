//
//  FetchConvertedPreviewUseCaseImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import Foundation
import Entity

public struct FetchConvertedPreviewUseCaseImpl: FetchConvertedPreviewUseCase {
    private let recipeConversionRepository: RecipeConversionRepository
    private let recipePreviewRepository: RecipePreviewRepository
    
    public init(
        recipeConversionRepository: RecipeConversionRepository,
        recipePreviewRepository: RecipePreviewRepository
    ) {
        self.recipeConversionRepository = recipeConversionRepository
        self.recipePreviewRepository = recipePreviewRepository
    }
    
    public func execute(_ source: String) async -> Result<RecipePreviewVO, Error> {
        do {
            let recipeID = try await recipeConversionRepository.convert(from: source)
            let preview = try await recipePreviewRepository.fetchPreview(for: recipeID)
            return .success(preview)
        } catch {
            return .failure(error)
        }
    }
}
