//
//  RecipeDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

protocol RecipeDataSource {
    func fetchRecipe(recipeID: UUID) async throws -> RecipeDTO
    func generateRecipe(from source: String) async throws -> UUID
}
