//
//  FetchRecipeStateUseCaseImpl.swift
//  Domain
//
//  Created by 디해 on 7/31/25.
//

import Entity
import Foundation

public struct FetchRecipeStateUseCaseImpl: FetchRecipeStateUseCase {
    private let recipeConversionRepository: RecipeConversionRepository
    
    public init(recipeConversionRepository: RecipeConversionRepository) {
        self.recipeConversionRepository = recipeConversionRepository
    }
    
    public func execute(recipeID: Int64) async -> Result<RecipeStateVO, Error> {
        do {
            let state = try await recipeConversionRepository.fetchState(of: recipeID)
            return .success(state)
        } catch {
            return .failure(error)
        }
    }
}
