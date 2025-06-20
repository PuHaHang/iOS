//
//  FetchRecipeDetailUseCase.swift
//  PuHaHang
//
//  Created by 디해 on 6/16/25.
//

import Foundation

protocol FetchRecipeDetailUseCase {
    func execute(recipeID: UUID) async -> Result<RecipeDetail, Error>
}
