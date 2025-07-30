//
//  EmptyFetchRecipeDetailUseCase.swift
//  Domain
//
//  Created by 디해 on 7/2/25.
//

import Entity
import Foundation

struct EmptyFetchRecipeDetailUseCase: FetchRecipeDetailUseCase {
    func execute(recipeID: Int64) async -> Result<RecipeDetailVO, any Error> {
        unimplementedFailure()
    }
}
