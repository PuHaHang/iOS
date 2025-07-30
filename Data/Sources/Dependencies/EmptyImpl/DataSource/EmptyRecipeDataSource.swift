//
//  EmptyRecipeDataSource.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Foundation

public struct EmptyRecipeDataSource: RecipeDataSource {
    public func fetchRecipe(recipeID: Int64) async throws -> RecipeDTO {
        throwUnimplemented()
    }
    
    public func generateRecipe(from source: String) async throws -> RecipeConversionDTO {
        throwUnimplemented()
    }
        throwUnimplemented()
    }
}

