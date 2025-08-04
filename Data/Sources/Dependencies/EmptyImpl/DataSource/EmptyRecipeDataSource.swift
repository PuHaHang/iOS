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
    
    public func fetchRecipeState(recipeID: Int64) async throws -> RecipeStateDTO {
        throwUnimplemented()
    }
    
    public func generateRecipe(from source: String) async throws -> RecipeConversionDTO {
        throwUnimplemented()
    }
    
    public func filterCompletedRecipeIDs(from ids: [Int64]) async throws -> CompletedRecipeDTO {
        throwUnimplemented()
    }
    
    public func deleteRecipe(recipeID: Int64) async throws {
        throwUnimplemented()
    }
}

