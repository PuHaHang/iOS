//
//  EmptyRecipePreviewDataSource.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Foundation

public struct EmptyRecipePreviewDataSource: RecipePreviewDataSource {
    public func fetchPreview(recipeID: Int64) async throws -> RecipePreviewDTO {
        throwUnimplemented()
    }
    
    public func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool) async throws -> RecipeListDTO {
        throwUnimplemented()
    }
    
    public func clearCache() throws {
        throwUnimplemented()
    }
}
