//
//  EmptyRecipePreviewRepository.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Domain
import Entity
import Foundation

struct EmptyRecipePreviewRepository: RecipePreviewRepository {
    func fetchPreview(for recipeID: Int64) async throws -> RecipePreviewVO {
        throwUnimplemented()
    }
    
    public func fetchPreviews(cursorId: Int?, size: Int, fromCache: Bool) async throws -> Entity.RecipeListVO {
        throwUnimplemented()
    }
}
