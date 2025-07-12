//
//  FetchRecipePreviewUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/12/25.
//

import Entity
import Foundation

public struct FetchRecipePreviewUseCaseImpl: FetchRecipePreviewUseCase {
    private let recipePreviewRepository: RecipePreviewRepository
    
    public init(recipePreviewRepository: RecipePreviewRepository) {
        self.recipePreviewRepository = recipePreviewRepository
    }
    
    public func execute(recipeID: UUID) async -> Result<RecipePreviewVO, Error> {
        do {
            let preview = try await recipePreviewRepository.fetchPreview(for: recipeID)
            return .success(preview)
        } catch {
            return .failure(error)
        }
    }
}
