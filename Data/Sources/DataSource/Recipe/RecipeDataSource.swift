//
//  RecipeDataSource.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation

public protocol RecipeDataSource {
    func fetchRecipe(recipeID: Int64) async throws -> RecipeDTO
    func generateRecipe(from source: String) async throws -> RecipeConversionDTO
}
