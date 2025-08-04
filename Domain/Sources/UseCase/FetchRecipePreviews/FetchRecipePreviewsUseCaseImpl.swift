//
//  FetchRecipePreviewsUseCaseImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct FetchRecipePreviewsUseCaseImpl: FetchRecipePreviewsUseCase {
    private let recipePreviewRepository: RecipePreviewRepository
    
    public init(recipePreviewRepository: RecipePreviewRepository) {
        self.recipePreviewRepository = recipePreviewRepository
    }
    
    public func execute(cursorId: Int?, size: Int) async -> Result<RecipeListVO, Error> {
        do {
            let list = try await recipePreviewRepository.fetchPreviews(cursorId: cursorId, size: size)
            return .success(list)
        } catch {
            return .failure(error)
        }
    }
}
