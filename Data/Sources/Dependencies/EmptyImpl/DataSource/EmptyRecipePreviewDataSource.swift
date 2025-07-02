//
//  EmptyRecipePreviewDataSource.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Foundation

public struct EmptyRecipePreviewDataSource: RecipePreviewDataSource {
    public func fetchPreview(recipeID: UUID) async throws -> RecipePreviewDTO {
        throwUnimplemented()
    }
    
    public func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewDTO] {
        throwUnimplemented()
    }
}
