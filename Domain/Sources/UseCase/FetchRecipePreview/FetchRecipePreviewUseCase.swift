//
//  FetchRecipePreviewUseCase.swift
//  Domain
//
//  Created by 디해 on 7/12/25.
//

import Entity
import Foundation

public protocol FetchRecipePreviewUseCase {
    func execute(recipeID: UUID) async -> Result<RecipePreviewVO, Error>
}
