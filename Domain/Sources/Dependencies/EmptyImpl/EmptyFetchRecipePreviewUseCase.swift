//
//  EmptyFetchRecipePreviewUseCase.swift
//  Domain
//
//  Created by 디해 on 7/12/25.
//

import Entity
import Foundation

struct EmptyFetchRecipePreviewUseCase: FetchRecipePreviewUseCase {
    func execute(recipeID: UUID) async -> Result<RecipePreviewVO, any Error> {
        unimplementedFailure()
    }
}
