//
//  FetchRecipeDetailUseCaseImpl.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation
import Entity

public struct FetchRecipeDetailUseCaseImpl: FetchRecipeDetailUseCase {
    private let recipeDetailRepository: RecipeDetailRepository
    
    public init(recipeDetailRepository: RecipeDetailRepository) {
        self.recipeDetailRepository = recipeDetailRepository
    }
    
    public func execute(recipeID: UUID) async -> Result<RecipeDetailVO, Error> {
        do {
            let detail = try await recipeDetailRepository.fetchDetail(for: recipeID)
            return .success(detail)
        } catch {
            return .failure(error)
        }
    }
}
