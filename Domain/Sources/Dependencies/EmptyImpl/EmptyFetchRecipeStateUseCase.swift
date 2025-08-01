//
//  EmptyFetchRecipeStateUseCase.swift
//  Domain
//
//  Created by 디해 on 7/31/25.
//

import Entity
import Foundation

struct EmptyFetchRecipeStateUseCase: FetchRecipeStateUseCase {
    func execute(recipeID: Int64) async -> Result<RecipeStateVO, any Error> {
        unimplementedFailure()
    }
}
