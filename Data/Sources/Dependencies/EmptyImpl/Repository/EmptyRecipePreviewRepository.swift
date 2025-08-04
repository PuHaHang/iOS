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
    
    func fetchPreviews(cursorId: Int?, size: Int) async throws -> RecipeListVO {
        throwUnimplemented()
    }
}
