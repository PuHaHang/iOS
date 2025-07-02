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
    func fetchPreview(for recipeID: UUID) async throws -> RecipePreviewVO {
        throwUnimplemented()
    }
    
    func fetchPreviews(page: Int, pageSize: Int) async throws -> [RecipePreviewVO] {
        throwUnimplemented()
    }
}
