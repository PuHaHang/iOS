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
    
    public func execute(page: Int, pageSize: Int) async -> Result<[RecipePreviewVO], Error> {
        do {
            let previews = try await recipePreviewRepository
                .fetchPreviews(page: page, pageSize: pageSize)
            return .success(previews)
        } catch {
            return .failure(error)
        }
    }
}
