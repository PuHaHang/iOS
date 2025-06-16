//
//  LiveFetchRecipePreviewsUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct LiveFetchRecipePreviewsUseCase: FetchRecipePreviewsUseCase {
    private let recipePreviewRepository: RecipePreviewRepository
    
    init(recipePreviewRepository: RecipePreviewRepository) {
        self.recipePreviewRepository = recipePreviewRepository
    }
    
    func execute(page: Int, pageSize: Int) async -> Result<[RecipePreview], Error> {
        do {
            let previews = try await recipePreviewRepository
                .fetchPreviews(page: page, pageSize: pageSize)
            return .success(previews)
        } catch {
            return .failure(error)
        }
    }
}
