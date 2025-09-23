//
//  DeleteRecipeUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 8/1/25.
//

import Foundation

public struct DeleteRecipeUseCaseImpl: DeleteRecipeUseCase {
    private let recipeDetailRepository: RecipeDetailRepository
    
    public init(recipeDetailRepository: RecipeDetailRepository) {
        self.recipeDetailRepository = recipeDetailRepository
    }
    
    public func execute(recipeID: Int64) async throws {
        try await recipeDetailRepository.delete(for: recipeID)
    }
}
