//
//  FetchCompletedRecipeConversionIDsUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/27/25.
//

import Foundation

public struct FetchCompletedRecipeConversionIDsUseCaseImpl: FetchCompletedRecipeConversionIDsUseCase {
    private let recipeConversionRepository: RecipeConversionRepository
    
    public init(recipeConversionRepository: RecipeConversionRepository) {
        self.recipeConversionRepository = recipeConversionRepository
    }
    
    public func execute(ids: [Int64]) async throws -> [Int64] {
        try await recipeConversionRepository.filterCompletedConversionRecipeIDs(from: ids)
    }
}
