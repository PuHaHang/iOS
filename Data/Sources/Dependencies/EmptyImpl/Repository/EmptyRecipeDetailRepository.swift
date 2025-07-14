//
//  EmptyRecipeDetailRepository.swift
//  Data
//
//  Created by 디해 on 7/2/25.
//

import Domain
import Entity
import Foundation

struct EmptyRecipeDetailRepository: RecipeDetailRepository {
    func fetchDetail(for recipeID: UUID) async throws -> Entity.RecipeDetailVO {
        throwUnimplemented()
    }
}
