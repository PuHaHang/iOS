//
//  LiveFetchRecipeDetailUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

struct LiveFetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
    private let recipeDetailRepository: RecipeDetailRepository
    
    init(recipeDetailRepository: RecipeDetailRepository) {
        self.recipeDetailRepository = recipeDetailRepository
    }
    
    func execute(recipeID: String) async -> Result<RecipeDetail, Error> {
        do {
            let detail = try await recipeDetailRepository.fetchDetail(for: recipeID)
            return .success(detail)
        } catch {
            return .failure(error)
        }
    }
}
